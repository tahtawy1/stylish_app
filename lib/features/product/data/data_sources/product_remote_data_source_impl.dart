import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:stylish_app/features/product/data/models/product_model.dart';
import 'package:stylish_app/features/product/domain/entities/paginated_result.dart';
import 'package:stylish_app/features/product/domain/entities/product_filter_model.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSourceImpl({required this.firestore});

  Query<Map<String, dynamic>> _applyFilter(
    Query<Map<String, dynamic>> query,
    ProductFilterModel? filter,
  ) {
    if (filter == null) return query;

    if (filter.minPrice != null) {
      query = query.where('price', isGreaterThanOrEqualTo: filter.minPrice);
    }
    if (filter.maxPrice != null) {
      query = query.where('price', isLessThanOrEqualTo: filter.maxPrice);
    }
    if (filter.ratingFourAndAbove) {
      query = query.where('averageRating', isGreaterThanOrEqualTo: 4);
    }

    // Only override the default orderBy when a price sort was explicitly chosen.
    if (filter.sortOption != null) {
      final descending = filter.sortOption == ProductSortOption.priceHighToLow;
      query = query.orderBy('price', descending: descending);
    }

    return query;
  }

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
    ProductFilterModel? filter,
  }) async {
    try {
      Query<Map<String, dynamic>> res = firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true);
      res = _applyFilter(res, filter);
      if (filter?.sortOption == null) {
        res = res.orderBy('createdAt', descending: true);
      }

      res = res.limit(limit + 1);

      final QuerySnapshot<Map<String, dynamic>> result;
      final cursorField = filter?.sortOption != null ? 'price' : 'createdAt';

      if (lastDocument != null) {
        result = await res.startAfter([
          lastDocument.data()![cursorField],
        ]).get();
      } else {
        result = await res.get();
      }

      final hasMore = result.docs.length > limit;

      final docs = hasMore ? result.docs.take(limit).toList() : result.docs;

      final products = docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return PaginatedResult(
        items: products,
        lastDocument: hasMore ? docs.last : null,
        hasMore: hasMore,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PaginatedResult<ProductModel>> getBestSellersProducts({
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    ProductFilterModel? filter,
  }) async {
    try {
      Query<Map<String, dynamic>> res = firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true);

      res = _applyFilter(res, filter);

      if (filter?.sortOption == null) {
        res = res.orderBy('totalSales', descending: true);
      }

      res = res.limit(limit + 1);

      final QuerySnapshot<Map<String, dynamic>> result;

      final cursorField = filter?.sortOption != null ? 'price' : 'totalSales';

      if (lastDocument != null) {
        result = await res.startAfter([
          lastDocument.data()![cursorField],
        ]).get();
      } else {
        result = await res.get();
      }

      final hasMore = result.docs.length > limit;

      final docs = hasMore ? result.docs.take(limit).toList() : result.docs;

      final products = docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return PaginatedResult(
        items: products,
        lastDocument: hasMore ? docs.last : null,
        hasMore: hasMore,
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
    ProductFilterModel? filter,
  }) async {
    try {
      Query<Map<String, dynamic>> res = firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true)
          .where('discountPercentage', isGreaterThan: 0);

      res = _applyFilter(res, filter);

      if (filter?.sortOption == null) {
        res = res.orderBy('discountPercentage', descending: true);
      }

      final QuerySnapshot<Map<String, dynamic>> result;

      final cursorField = filter?.sortOption != null
          ? 'price'
          : 'discountPercentage';

      if (lastDocument != null) {
        result = await res.startAfter([
          lastDocument.data()![cursorField],
        ]).get();
      } else {
        result = await res.get();
      }

      final hasMore = result.docs.length > limit;

      final docs = hasMore ? result.docs.take(limit).toList() : result.docs;

      final products = docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return PaginatedResult(
        items: products,
        lastDocument: hasMore ? docs.last : null,
        hasMore: hasMore,
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
    ProductFilterModel? filter,
  }) async {
    try {
      Query<Map<String, dynamic>> res = firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true)
          .where('categoryId', isEqualTo: categoryId);

      res = _applyFilter(res, filter);

      if (filter?.sortOption == null) {
        res = res.orderBy('createdAt', descending: true);
      }

      res = res.limit(limit + 1);

      final QuerySnapshot<Map<String, dynamic>> result;
      final cursorField = filter?.sortOption != null ? 'price' : 'createdAt';

      if (lastDocument != null) {
        result = await res.startAfter([
          lastDocument.data()![cursorField],
        ]).get();
      } else {
        result = await res.get();
      }

      final hasMore = result.docs.length > limit;

      final docs = hasMore ? result.docs.take(limit).toList() : result.docs;

      final products = docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return PaginatedResult(
        items: products,
        lastDocument: hasMore ? docs.last : null,
        hasMore: hasMore,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
