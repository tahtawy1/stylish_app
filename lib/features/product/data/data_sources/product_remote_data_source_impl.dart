import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:stylish_app/features/product/data/models/product_model.dart';
import 'package:stylish_app/features/product/domain/entities/paginated_result.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final result = await firestore.collection('products').get();
      final products = result.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PaginatedResult<ProductModel>> getNewArrivalsProducts({
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  }) async {
    try {
      final res = firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      final QuerySnapshot<Map<String, dynamic>> result;
      if (lastDocument != null) {
        result = await res.startAfterDocument(lastDocument).get();
      } else {
        result = await res.get();
      }
      final products = result.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return PaginatedResult(
        items: products,
        lastDocument: result.docs.isNotEmpty ? result.docs.last : null,
        hasMore: result.docs.length == limit,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PaginatedResult<ProductModel>> getBestSellersProducts({
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  }) async {
    try {
      final res = firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true)
          .orderBy('totalSales', descending: true)
          .limit(limit);
      final result = lastDocument != null
          ? await res.startAfterDocument(lastDocument).get()
          : await res.get();
      final products = result.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return PaginatedResult(
        items: products,
        lastDocument: result.docs.isNotEmpty ? result.docs.last : null,
        hasMore: result.docs.length == limit,
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<PaginatedResult<ProductModel>> getOnSaleProducts({
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  }) async {
    try {
      final res = firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true)
          .where('discountPercentage', isGreaterThan: 0)
          .orderBy('discountPercentage');
      final result = lastDocument != null
          ? await res.startAfterDocument(lastDocument).limit(limit).get()
          : await res.limit(limit).get();
      final products = result.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return PaginatedResult(
        items: products,
        lastDocument: result.docs.isNotEmpty ? result.docs.last : null,
        hasMore: result.docs.length == limit,
      );
    } catch (e) {
      log(e.toString());

      throw Exception(e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById({required String id}) async {
    try {
      final result = await firestore.collection('products').doc(id).get();
      if (result.exists) {
        return ProductModel.fromJson(result.data()!);
      }
      throw Exception('Product not found'); // TODO: add a custom exception
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PaginatedResult<ProductModel>> getProductsByCategory({
    required String categoryId,
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  }) async {
    try {
      final res = firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true)
          .where('categoryId', isEqualTo: categoryId)
          .orderBy('createdAt', descending: true)
          .limit(limit);
      final result = lastDocument != null
          ? await res.startAfterDocument(lastDocument).get()
          : await res.get();
      final products = result.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return PaginatedResult(
        items: products,
        lastDocument: result.docs.isNotEmpty ? result.docs.last : null,
        hasMore: result.docs.length == limit,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
