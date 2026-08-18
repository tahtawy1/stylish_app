import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/features/review/domain/entities/review_entity.dart';
import 'package:stylish_app/features/review/presentation/view_model/review_cubit/review_cubit.dart';
import 'package:stylish_app/features/review/presentation/widgets/rating_summary_section/rating_summary_section.dart';
import 'package:stylish_app/features/review/presentation/widgets/reviews_header_section.dart';
import 'package:stylish_app/features/review/presentation/widgets/reviews_list_section/reviews_list_section.dart';

class ProductReviewsView extends StatefulWidget {
  const ProductReviewsView({
    super.key,
    required this.productId,
    required this.averageRating,
    required this.totalRatings,
    required this.totalReviewsWithComments,
  });

  final String productId;
  final double averageRating;
  final int totalRatings;
  final int totalReviewsWithComments;

  @override
  State<ProductReviewsView> createState() => _ProductReviewsViewState();
}

class _ProductReviewsViewState extends State<ProductReviewsView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReviewCubit>().getProductReviews(
        productId: widget.productId,
      );
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 500) {
      context.read<ReviewCubit>().loadMoreReviews(productId: widget.productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: AppBar(
        title: Text(
          context.l10n.reviewsTitle,
          style: context.textStyle.titleLarge,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingSummarySection(
                score: widget.averageRating,
                totalRatings: widget.totalRatings,
              ),
              const SizedBox(height: 8),

              ReviewsHeaderSection(
                totalReviews: widget
                    .totalReviewsWithComments, //? reviews with comments . length
                onSortTap: () {
                  // Future logic for sorting bottom sheet / dialog
                },
              ),
              const SizedBox(height: 8),

              // todo get reviews list from firestore
              BlocBuilder<ReviewCubit, ReviewState>(
                builder: (context, state) {
                  log(widget.productId);
                  final isLoading =
                      state.status == ReviewStatus.loading ||
                      state.status == ReviewStatus.initial;

                  final isFailure = state.status == ReviewStatus.failure;
                  final reviews = isLoading
                      ? List.generate(5, (_) => ReviewEntity.fake())
                      : state.reviews;

                  if (isFailure && reviews.isEmpty) {
                    log(state.errorMessage ?? '');
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          state.errorMessage ?? context.l10n.unexpectedError,
                          style: context.textStyle.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } // todo: Fetch products

                  if (!isLoading && reviews.isEmpty) {
                    return Center(
                      child: Text(
                        context.l10n.noReviews,
                        style: context.textStyle.bodyLarge,
                      ),
                    );
                  }

                  return Skeletonizer(
                    enabled: isLoading,
                    child: ReviewsListSection(reviews: reviews),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
