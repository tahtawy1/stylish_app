import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/features/review/presentation/widgets/star_rating_widget.dart';

class RatingBreakdownRow extends StatelessWidget {
  const RatingBreakdownRow({
    super.key,
    required this.stars,
    required this.percentage,
  });

  final int stars;
  final double percentage; // Value between 0.0 and 1.0

  @override
  Widget build(BuildContext context) {
    final trackColor = context.isDarkMode
        ? AppColors.grey4.withValues(alpha: 0.3)
        : AppColors.grey10;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          StarRatingWidget(
            rating: stars.toDouble(),
            starSize: 13,
            spacing: 2,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: SizedBox(
                height: 5,
                child: LinearProgressIndicator(
                  value: percentage.clamp(0.0, 1.0),
                  backgroundColor: trackColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.colors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingBreakdownList extends StatelessWidget {
  const RatingBreakdownList({
    super.key,
    this.breakdownPercentages = const [0.82, 0.52, 0.26, 0.12, 0.04],
  });

  final List<double> breakdownPercentages;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starCount = 5 - index;
        final percentage = index < breakdownPercentages.length
            ? breakdownPercentages[index]
            : 0.0;
        return RatingBreakdownRow(
          stars: starCount,
          percentage: percentage,
        );
      }),
    );
  }
}
