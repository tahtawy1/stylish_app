import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

/// Bottom navigation text with a tappable underlined action link.
/// Used on login ("Don't have an account? Join") and register
/// ("Already have an account? Log In").
class AuthBottomNavText extends StatelessWidget {
  const AuthBottomNavText({
    super.key,
    required this.prefixText,
    required this.actionText,
    required this.onActionTap,
  });

  final String prefixText;
  final String actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prefixText,
          style: context.textStyle.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: context.textStyle.bodyMedium?.copyWith(
              color: context.colors.onSurface,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
