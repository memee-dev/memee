import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/shared/app_firestore.dart';
import 'package:memee/models/product_entity.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FirebaseFirestore db;

  ProductCubit(this.db) : super(ProductInitial());

  fetchProducts() {
    emit(ProductLoading());

    List<ProductEntity> products = [];
    final CollectionReference reference =
        db.collection(AppFireStoreCollection.products);

    reference.get().then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.map((e) {
          Map<String, dynamic>? data = e.data() as Map<String, dynamic>;

          products.add(ProductEntity.fromJson(data));
        }).toList();
        emit(ProductSuccess(products: products));
      }
    });
  }
}
