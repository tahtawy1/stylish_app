import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/core/pagination/paginated_result.dart';
import 'package:stylish_app/features/review/data/data_sources/review_remote_data_source.dart';
import 'package:stylish_app/features/review/domain/entities/review_entity.dart';
import 'package:stylish_app/features/review/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedResult<ReviewEntity>>> getProductReviews({
    required String productId,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    int limit = 20,
  }) async {
    try {
      final result = await remoteDataSource.getProductReviews(
        productId: productId,
        lastDocument: lastDocument,
        limit: limit,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
