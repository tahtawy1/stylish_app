import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/category/data/data_sources/category_remote_data_source.dart';
import 'package:stylish_app/features/category/data/models/category_model.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final FirebaseFirestore firestore;

  CategoryRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<CategoryModel>> getCategories({int? limit}) async {
    try {
      final collection = firestore.collection('categories');

      final query = limit != null ? collection.limit(limit) : collection;

      final snapshot = await query.get();

      return snapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<CategoryModel> getCategoryById({required String id}) async {
    try {
      final snapshot = await firestore.collection('categories').doc(id).get();
      if (snapshot.exists) {
        return CategoryModel.fromJson(snapshot.data()!);
      }
      throw Exception('Category not found'); // todo : make it app exception
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString()); // todo : make it app exception
    }
  }
}
