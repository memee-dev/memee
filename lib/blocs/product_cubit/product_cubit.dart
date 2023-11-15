import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/shared/app_firestore.dart';
import 'package:memee/models/product_entity.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FirebaseFirestore db;

  ProductCubit(this.db) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());

    try {
      final CollectionReference reference =
        db.collection(AppFireStoreCollection.products);


    final res = await reference.get();
    List<ProductEntity> products = [];
    if (res.docs.isNotEmpty) {
      res.docs.map((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
        products.add(ProductEntity.fromJson(data));
      }).toList();
      emit(ProductSuccess(products: products));
    } else {
      emit(const ProductFailure(message: 'No data'));
    }
    } catch (e) {
      emit(ProductFailure(message: e.toString()));
    }
    
  }
}
