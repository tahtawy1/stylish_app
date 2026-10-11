import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/core/pagination/paginated_result.dart';
import 'package:stylish_app/features/review/data/models/review_model.dart';

abstract class ReviewRemoteDataSource {
  Future<PaginatedResult<ReviewModel>> getProductReviews({
    required String productId,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    int limit = 20,
  });
}
