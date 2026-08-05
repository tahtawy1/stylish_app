import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/home/domain/entities/product_entity.dart';

abstract class ProductRepository {
  // add product
  // update product
  // delete product
  // get all products
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  // get product by id
  // get products by category
}
