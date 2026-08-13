import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/product/data/models/product_model.dart';
import 'package:stylish_app/features/product/domain/entities/paginated_result.dart';
import 'package:stylish_app/features/product/domain/entities/product_filter_model.dart';

abstract class ProductRemoteDataSource {
  // add product
  // update product
  // delete product
  // get all products
  Future<List<ProductModel>> getAllProducts();
  Future<PaginatedResult<ProductModel>> getNewArrivalsProducts({
    int limit,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    ProductFilterModel? filter,
  });
  Future<PaginatedResult<ProductModel>> getBestSellersProducts({
    int limit,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    ProductFilterModel? filter,
  });
  Future<PaginatedResult<ProductModel>> getOnSaleProducts({
    int limit,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    ProductFilterModel? filter,
  });
  // get product by id
  Future<ProductModel> getProductById({required String id});
  // get products by ids using FieldPath.documentId whereIn with chunking
  Future<List<ProductModel>> getProductsByIds({required List<String> ids});
  Future<PaginatedResult<ProductModel>> getProductsByCategory({
    required String categoryId,
    int limit,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    ProductFilterModel? filter,
  });
}
