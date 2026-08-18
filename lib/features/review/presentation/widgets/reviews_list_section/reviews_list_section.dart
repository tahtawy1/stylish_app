import 'package:flutter/material.dart';
import 'package:stylish_app/features/review/domain/entities/review_entity.dart';
import 'package:stylish_app/features/review/presentation/widgets/reviews_list_section/review_card.dart';

class ReviewsListSection extends StatelessWidget {
  const ReviewsListSection({super.key, required this.reviews});

  final List<ReviewEntity> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(reviews.length, (index) {
        return ReviewCard(
          review: reviews[index],
          showDivider: index < reviews.length - 1,
        );
      }),
    );
  }
}
