import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/core/utils/app_logger.dart';
import 'package:memee/models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FirebaseFirestore db;

  ProductCubit(this.db) : super(ProductInitial());

  Future<void> fetchProducts() async {
    List<ProductModel> products = [];
    emit(ProductLoading());
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
      emit(ProductSuccess(products: products));
    } catch (e) {
      emit(ProductFailure(
        message: e.toString(),
        products,
      ));
      console.e('FETCH Products', error: e);
    }
  }
}
