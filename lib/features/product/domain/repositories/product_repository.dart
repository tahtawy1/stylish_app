import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/product/domain/entities/paginated_result.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  // add product
  // update product
  // delete product
  // get all products
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, PaginatedResult<ProductEntity>>>
  getNewArrivalsProducts({
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  });
  Future<Either<Failure, PaginatedResult<ProductEntity>>>
  getBestSellersProducts({
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  });
  Future<Either<Failure, PaginatedResult<ProductEntity>>> getOnSaleProducts({
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  });
  // get product by id
  Future<Either<Failure, ProductEntity>> getProductById({required String id});
  // get products by category
  Future<Either<Failure, PaginatedResult<ProductEntity>>>
  getProductsByCategory({
    required String categoryId,
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  });
}
