import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/repositories/product_repository.dart';

class GetProductsByIdsUseCase {
  final ProductRepository repository;

  GetProductsByIdsUseCase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call({
    required List<String> ids,
  }) {
    return repository.getProductsByIds(ids: ids);
  }
}
