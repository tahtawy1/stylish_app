import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/category/data/data_sources/category_remote_data_source.dart';
import 'package:stylish_app/features/category/data/models/category_model.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final FirebaseFirestore firestore;

  CategoryRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<CategoryModel>> getCategories({int limit = 5}) async {
    try {
      final snapshot = await firestore
          .collection('categories')
          .limit(limit)
          .get();
      return snapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
