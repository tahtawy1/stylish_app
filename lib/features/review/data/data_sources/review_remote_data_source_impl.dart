import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/core/pagination/paginated_result.dart';
import 'package:stylish_app/features/review/data/data_sources/review_remote_data_source.dart';
import 'package:stylish_app/features/review/data/models/review_model.dart';

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final FirebaseFirestore firestore;

  ReviewRemoteDataSourceImpl({required this.firestore});
  @override
  Future<PaginatedResult<ReviewModel>> getProductReviews({
    required String productId,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    int limit = 20,
  }) async {
    try {
      var query = firestore
          .collection('reviews')
          .doc(productId)
          .collection('items')
          .orderBy('createdAt', descending: true);
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }
      final result = await query.limit(limit + 1).get();
      final hasMore = result.docs.length > limit;

      final docs = hasMore ? result.docs.take(limit).toList() : result.docs;

      final reviews = docs.map((e) => ReviewModel.fromJson(e.data())).toList();
      return PaginatedResult(
        items: reviews,
        lastDocument: hasMore ? docs.last : null,
        hasMore: hasMore,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
