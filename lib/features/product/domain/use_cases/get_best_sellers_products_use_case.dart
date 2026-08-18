import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/core/pagination/paginated_result.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/entities/product_filter_model.dart';
import 'package:stylish_app/features/product/domain/repositories/product_repository.dart';

class GetBestSellersProductsUseCase {
  final ProductRepository productRepository;

  GetBestSellersProductsUseCase({required this.productRepository});

  Future<Either<Failure, PaginatedResult<ProductEntity>>> call({
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    ProductFilterModel? filter,
  }) async {
    return await productRepository.getBestSellersProducts(
      limit: limit,
      lastDocument: lastDocument,
      filter: filter,
    );
  }
}
