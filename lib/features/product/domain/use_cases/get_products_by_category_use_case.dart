import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/product/domain/entities/paginated_result.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/entities/product_filter_model.dart';
import 'package:stylish_app/features/product/domain/repositories/product_repository.dart';

class GetProductsByCategoryUseCase {
  final ProductRepository productRepository;

  GetProductsByCategoryUseCase({required this.productRepository});

  Future<Either<Failure, PaginatedResult<ProductEntity>>> call({
    required String categoryId,
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    ProductFilterModel? filter,
  }) {
    return productRepository.getProductsByCategory(
      categoryId: categoryId,
      limit: limit,
      lastDocument: lastDocument,
      filter: filter,
    );
  }
}
