import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/core/pagination/paginated_result.dart';
import 'package:stylish_app/features/review/domain/entities/review_entity.dart';
import 'package:stylish_app/features/review/domain/repositories/review_repository.dart';

class GetProductReviewsUseCase {
  final ReviewRepository repository;

  GetProductReviewsUseCase({required this.repository});

  Future<Either<Failure, PaginatedResult<ReviewEntity>>> call({
    required String productId,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    int limit = 20,
  }) async {
    return await repository.getProductReviews(
      productId: productId,
      lastDocument: lastDocument,
      limit: limit,
    );
  }
}
