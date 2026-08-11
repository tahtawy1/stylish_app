import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/product/data/models/product_model.dart';
import 'package:stylish_app/features/product/domain/entities/paginated_result.dart';

abstract class ProductRemoteDataSource {
  // add product
  // update product
  // delete product
  // get all products
  Future<List<ProductModel>> getAllProducts();
  Future<PaginatedResult<ProductModel>> getNewArrivalsProducts({
    int limit,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  });
  Future<PaginatedResult<ProductModel>> getBestSellersProducts({
    int limit,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  });
  Future<PaginatedResult<ProductModel>> getOnSaleProducts({
    int limit,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  });
  // get product by id
  Future<ProductModel> getProductById({required String id});
  Future<PaginatedResult<ProductModel>> getProductsByCategory({
    required String categoryId,
    int limit,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  });
}
