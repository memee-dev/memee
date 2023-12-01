import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/utils/app_firestore.dart';

import '../../core/utils/app_logger.dart';
import '../../models/category_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final FirebaseFirestore db;
  final collectionName = AppFireStoreCollection.categories;

  CategoriesCubit(this.db) : super(CategoriesLoading());

  Future<void> fetchCategories() async {
    List<CategoryModel> categories = [];
    emit(CategoriesLoading());
    try {
      final categoryDoc = await db.collection(collectionName).get();

      final docs = categoryDoc.docs;

      for (var doc in docs) {
        final data = doc.data();
        data['id'] = doc.id;
        categories.add(CategoryModel.fromMap(data));
      }

      emit(CategoriesSuccess(categories));
    } catch (e) {
      emit(CategoriesFailure(
        e.toString(),
        categories,
      ));
      console.e('FETCH CATEGORY', error: e);
    }
  }

  List<CategoryModel> getLocalCategories() {
    List<CategoryModel> categories = [];
    if (state is CategoriesSuccess) {
      categories.addAll((state as CategoriesSuccess).categories);
    } else if (state is CategoriesFailure) {
      categories.addAll((state as CategoriesFailure).categories);
    }
    return categories;
  }
}
