import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/features/review/presentation/widgets/rating_summary_section/rating_score_widget.dart';

class RatingSummarySection extends StatelessWidget {
  const RatingSummarySection({
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
      children: [
        RatingScoreWidget(score: score, totalRatings: totalRatings),
        const SizedBox(height: 20),
        Divider(
          thickness: 1,
          color: context.colors.outline.withValues(alpha: 0.2),
        ),
      ],
    );
  }
}
