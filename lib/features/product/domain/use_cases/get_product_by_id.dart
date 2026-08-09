import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository productRepository;

  GetProductByIdUseCase({required this.productRepository});

  Future<Either<Failure, ProductEntity>> call({required String id}) async {
    return await productRepository.getProductById(id: id);
  }
}
