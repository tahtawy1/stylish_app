import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  // add product
  // update product
  // delete product
  // get all products
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, List<ProductEntity>>> getNewArrivalsProducts({
    int limit = 20,
  });
  Future<Either<Failure, List<ProductEntity>>> getBestSellersProducts({
    int limit = 20,
  });
  Future<Either<Failure, List<ProductEntity>>> getOnSaleProducts({
    int limit = 20,
  });
  // get product by id
  // get products by category
}
