import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

/// Reusable header widget used on all auth screens (login / register / forgot-password).
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textStyle.displayMedium),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: context.textStyle.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
