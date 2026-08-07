import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/repositories/product_repository.dart';

class GetBestSellersProductsUseCase {
  final ProductRepository productRepository;

  GetBestSellersProductsUseCase({required this.productRepository});
  Future<Either<Failure, List<ProductEntity>>> call({int limit = 20}) async {
    return await productRepository.getBestSellersProducts(limit: limit);
  }
}
