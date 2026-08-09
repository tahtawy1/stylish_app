import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

/// "Forgot your password? Reset your password" inline row shown below
/// the password field on the Login screen.
class LoginForgotPasswordRow extends StatelessWidget {
  const LoginForgotPasswordRow({
    super.key,
    required this.prefixText,
    required this.actionText,
    this.onTap,
  });

  final String prefixText;
  final String actionText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          prefixText,
          style: context.textStyle.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: context.textStyle.bodySmall?.copyWith(
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
