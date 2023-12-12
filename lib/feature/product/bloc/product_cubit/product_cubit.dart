import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/core/utils/app_logger.dart';
import 'package:memee/models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FirebaseFirestore db;
  final FirebaseAuth auth;

  ProductCubit(this.db, this.auth) : super(ProductInitial());

  List<ProductModel> products = [];

  Future<void> fetchProducts(String categoryId) async {
    emit(ProductLoading());
    try {
      final prodDoc =
          await db.collection(AppFireStoreCollection.products).get();
      final docs = prodDoc.docs;

      for (var doc in docs) {
        final data = doc.data();

        data['id'] = doc.id;

        if (categoryId.isNotEmpty) {
          if (data['category']['id'].toString().equals(categoryId)) {
            products.add(
              ProductModel.fromMap(data),
            );
          }
        } else {
          products.add(
            ProductModel.fromMap(data),
          );
        }
      }

      emit(ProductSuccess(products: products));
    } catch (e) {
      emit(ProductFailure(
        message: e.toString(),
        products,
      ));
      console.e('FETCH Products', error: e);
    }
  }

  bool searching = false;

  Future<void> searchProducts(context, String searchQuery) async {
    List<ProductModel> _searchedProducts = [];
    try {
      searchQuery = searchQuery.trim();
      if (searchQuery.trim().length > 3) {
        emit(ProductLoading());
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

        emit(ProductSuccess(products: _searchedProducts));
      } else {
        if (searching) {
          emit(ProductLoading());
          emit(ProductSuccess(products: products));
        }
      }
    } catch (e) {
      emit(ProductFailure(
        products,
        message: e.toString(),
      ));
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
        emit(ProductSuccess(products: products));
      }
    } catch (e) {
      console.e(e);
    }
  }
}
