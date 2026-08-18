import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/review/domain/entities/review_entity.dart';
import 'package:stylish_app/features/review/domain/use_cases/get_product_reviews_use_case.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final GetProductReviewsUseCase getProductReviewsUseCase;
  ReviewCubit({required this.getProductReviewsUseCase})
    : super(const ReviewState());

  Future<void> getProductReviews({required String productId}) async {
    emit(
      state.copyWith(
        status: ReviewStatus.loading,
        reviews: [],
        lastDocument: null,
        hasMore: true,
      ),
    );

    final result = await getProductReviewsUseCase(
      productId: productId,
      lastDocument: state.lastDocument,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ReviewStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (result) => emit(
        state.copyWith(
          status: ReviewStatus.success,
          hasMore: result.hasMore,
          reviews: result.items,
          lastDocument: result.lastDocument,
        ),
      ),
    );
  }

  void loadMoreReviews({required String productId}) async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final result = await getProductReviewsUseCase(
      productId: productId,
      lastDocument: state.lastDocument,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ReviewStatus.failure,
          errorMessage: failure.message,
          isLoadingMore: false,
        ),
      ),
      (result) => emit(
        state.copyWith(
          status: ReviewStatus.success,
          hasMore: result.hasMore,
          reviews: state.reviews + result.items,
          lastDocument: result.lastDocument,
          isLoadingMore: false,
        ),
      ),
    );
  }
}
