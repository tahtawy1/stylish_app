import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class ReviewsHeaderSection extends StatelessWidget {
  const ReviewsHeaderSection({
    super.key,
    this.totalReviews = 45,
    this.selectedSort = '',
    this.onSortTap,
  });

  final int totalReviews;
  final String selectedSort;
  final VoidCallback? onSortTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$totalReviews ${context.l10n.reviewsTitle}',
          style: context.textStyle.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
        InkWell(
          onTap: onSortTap,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedSort.isNotEmpty
                      ? selectedSort
                      : context.l10n.mostRelevant,
                  style: context.textStyle.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: context.colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
