import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

/// A bordered social-auth button (e.g. "Login with Google").
/// Pass [backgroundColor] and [foregroundColor] to tint the button
/// (used for the Facebook filled variant).
class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String label;
  final String iconPath;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final bool isFilled = backgroundColor != null;

    return SizedBox(
      height: 54,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isFilled ? backgroundColor : Colors.transparent,
          side: BorderSide(
            color: isFilled ? Colors.transparent : context.colors.outline,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(width: 8),
            Text(
              label,
              style: context.textStyle.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: isFilled ? foregroundColor : context.colors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
