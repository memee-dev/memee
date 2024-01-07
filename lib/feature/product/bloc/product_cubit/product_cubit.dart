import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/core/utils/app_logger.dart';
import 'package:memee/models/product_model.dart';

enum ProductState {
  initial,
  loading,
  success,
  error,
}

class ProductCubit extends Cubit<ProductState> {
  final FirebaseFirestore db;
  final FirebaseAuth auth;

  ProductCubit(this.db, this.auth) : super(ProductState.initial);

  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  String error = '';
  ProductModel? product;

  Future<void> fetchProducts() async {
    products = [];
    emit(ProductState.loading);
    try {
      final prodDoc =
          await db.collection(AppFireStoreCollection.products).get();
      final docs = prodDoc.docs;

      for (var doc in docs) {
        final data = doc.data();

        data['id'] = doc.id;

        products.add(
          ProductModel.fromMap(data),
        );
      }

      emit(ProductState.success);
    } catch (e) {
      error = e.toString();
      products = [];
      emit(ProductState.error);
      console.e('FETCH Products', error: e);
    }
  }

  bool searching = false;

  Future<void> searchProducts(context, String searchQuery) async {
    List<ProductModel> _searchedProducts = [];
    try {
      searchQuery = searchQuery.trim();
      if (searchQuery.trim().length > 3) {
        emit(ProductState.loading);
        searching = true;
        final query = locator
            .get<Algolia>()
            .instance
            .index(AppFireStoreCollection.products)
            .query(searchQuery);
        final snap = await query.getObjects();

        final hits = snap.hits;

        for (var hit in hits) {
          _searchedProducts.add(
              products.firstWhere((element) => element.id == hit.objectID));
        }

        filteredProducts = _searchedProducts;
        emit(ProductState.success);
      } else {
        if (searching) {
          emit(ProductState.loading);
          emit(ProductState.success);
        }
      }
    } catch (e) {
      error = e.toString();
      products = [];
      emit(ProductState.error);
      console.e('SEARCH Products', error: e);
    }
  }

  updateFavourite(ProductModel product) async {
    try {
      User? user = auth.currentUser;

      if (user != null) {
        final prodDoc =
            await db.collection(AppFireStoreCollection.products).get();
        final docs = prodDoc.docs;

        for (var doc in docs) {
          final data = doc.data();
          data['id'] = doc.id;
          if (data['id'] == product.id) {
            data['favourite'] = product.favourite;
            doc.reference.update(data);
          }
          products.add(
            ProductModel.fromMap(data),
          );
        }
        emit(ProductState.success);
      }
    } catch (e) {
      console.e(e);
    }
  }

  fetchProductsBasedCategories(String categoryId) {
    emit(ProductState.loading);
    List<ProductModel> _catProducts = [];
    if (products.isNotEmpty) {
      for (var item in products) {
        if (item.category == categoryId) {
          _catProducts.add(item);
        }
      }

      filteredProducts = _catProducts;
      emit(ProductState.success);
    }
  }
}
