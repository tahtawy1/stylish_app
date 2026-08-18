import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/features/review/presentation/widgets/star_rating_widget.dart';

class RatingScoreWidget extends StatelessWidget {
  const RatingScoreWidget({
    super.key,
    this.score = 4.0,
    this.totalRatings = 1034,
  });

  final double score;
  final int totalRatings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          score.toStringAsFixed(1),
          style: context.textStyle.displayLarge?.copyWith(
            color: context.colors.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        StarRatingWidget(rating: score, starSize: 24, spacing: 3),
        const SizedBox(height: 6),
        Text(
          '$totalRatings ${context.l10n.ratings}',
          style: context.textStyle.bodyLarge?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
