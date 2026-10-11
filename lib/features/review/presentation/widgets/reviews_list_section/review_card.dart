import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/features/review/domain/entities/review_entity.dart';
import 'package:stylish_app/features/review/presentation/widgets/star_rating_widget.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review, this.showDivider = true});

  final ReviewEntity review;
  final bool showDivider;

  String _formatRelativeTime(BuildContext context, DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inDays < 1) {
      return context.l10n.timeToday;
    } else if (difference.inDays < 7) {
      return context.l10n.daysAgo(difference.inDays);
    } else if (difference.inDays < 14) {
      return context.l10n.oneWeekAgo;
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return context.l10n.weeksAgo(weeks);
    } else {
      final months = (difference.inDays / 30).floor();
      if (months == 1) {
        return context.l10n.oneMonthAgo;
      }
      return context.l10n.monthsAgo(months);
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = review.userName ?? context.l10n.defaultUserName;
    final formattedDate = _formatRelativeTime(context, review.createdAt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        StarRatingWidget(rating: review.rating, starSize: 16, spacing: 3),
        if (review.comment != null && review.comment!.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            review.comment!,
            style: context.textStyle.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              name,
              style: context.textStyle.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.onSurface,
              ),
            ),
            Text(
              ' • ',
              style: context.textStyle.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            Text(
              formattedDate,
              style: context.textStyle.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (showDivider)
          Divider(
            thickness: 1,
            color: context.colors.outline.withValues(alpha: 0.2),
          ),
      ],
    );
  }
}
