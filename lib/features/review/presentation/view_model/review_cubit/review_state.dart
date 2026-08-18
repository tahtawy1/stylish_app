part of 'review_cubit.dart';

enum ReviewStatus { initial, loading, success, failure }

final class ReviewState {
  final List<ReviewEntity> reviews;
  final ReviewStatus status;
  final String? errorMessage;
  final bool hasMore;
  final DocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final bool isLoadingMore;

  const ReviewState({
    this.reviews = const [],
    this.status = ReviewStatus.initial,
    this.errorMessage,
    this.hasMore = true,
    this.lastDocument,
    this.isLoadingMore = false,
  });

  ReviewState copyWith({
    List<ReviewEntity>? reviews,
    ReviewStatus? status,
    String? errorMessage,
    bool? hasMore,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    bool? isLoadingMore,
  }) {
    return ReviewState(
      reviews: reviews ?? this.reviews,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      hasMore: hasMore ?? this.hasMore,
      lastDocument: lastDocument ?? this.lastDocument,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
