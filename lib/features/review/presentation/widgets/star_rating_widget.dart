import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.starSize = 16.0,
    this.filledColor = const Color(0xFFFFB800),
    this.emptyColor,
    this.spacing = 2.0,
  });

  final double rating;
  final int maxRating;
  final double starSize;
  final Color filledColor;
  final Color? emptyColor;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final inactiveColor = emptyColor ??
        (context.isDarkMode
            ? AppColors.grey4.withValues(alpha: 0.4)
            : AppColors.grey10);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final starValue = index + 1;
        IconData iconData;
        Color color;

        if (rating >= starValue) {
          iconData = Icons.star_rounded;
          color = filledColor;
        } else if (rating >= starValue - 0.5) {
          iconData = Icons.star_half_rounded;
          color = filledColor;
        } else {
          iconData = Icons.star_rounded;
          color = inactiveColor;
        }

        return Padding(
          padding: EdgeInsets.only(right: index == maxRating - 1 ? 0 : spacing),
          child: Icon(
            iconData,
            size: starSize,
            color: color,
          ),
        );
      }),
    );
  }
}
