import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.postfixIcon,
    this.enabled = true,
    this.onPressed,
  });

  final String title;
  final IconData? postfixIcon;
  final bool enabled;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        height: 54,
        width: double.infinity,
        decoration: BoxDecoration(
          color: enabled ? context.colors.primary : context.colors.outline,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: context.textStyle.bodyMedium?.copyWith(
                color: context.colors.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (postfixIcon != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 8),
                child: Icon(
                  postfixIcon,
                  color: context.colors.onPrimary,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
