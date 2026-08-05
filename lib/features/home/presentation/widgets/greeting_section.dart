import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/utils/greeting_helper.dart';
import 'package:stylish_app/features/home/presentation/widgets/notification_button.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({
    super.key,
    this.userName = 'Albert Stevano',
    this.onNotificationTap,
  });

  final String userName;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getGreeting(context),
              style: context.textStyle.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              userName,
              style: context.textStyle.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.onSurface,
              ),
            ),
          ],
        ),
        NotificationButton(onTap: onNotificationTap),
      ],
    );
  }
}
