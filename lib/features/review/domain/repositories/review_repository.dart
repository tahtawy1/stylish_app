import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/core/pagination/paginated_result.dart';
import 'package:stylish_app/features/review/domain/entities/review_entity.dart';

abstract class ReviewRepository {
  Future<Either<Failure, PaginatedResult<ReviewEntity>>> getProductReviews({
    required String productId,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    int limit = 20,
  });
}
