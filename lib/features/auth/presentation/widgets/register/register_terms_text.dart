import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

/// "By signing up you agree to our Terms, Privacy Policy and Cookie Use"
/// legal text shown below the password field on the Register screen.
/// Each highlighted word is individually tappable.
class RegisterTermsText extends StatelessWidget {
  const RegisterTermsText({
    super.key,
    required this.prefix,
    required this.termsLabel,
    required this.privacyLabel,
    required this.andLabel,
    required this.cookieLabel,
    this.onTermsTap,
    this.onPrivacyTap,
    this.onCookieTap,
  });

  final String prefix;
  final String termsLabel;
  final String privacyLabel;
  final String andLabel;
  final String cookieLabel;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;
  final VoidCallback? onCookieTap;

  @override
  Widget build(BuildContext context) {
    final baseStyle = context.textStyle.bodySmall?.copyWith(
      color: context.colors.onSurfaceVariant,
    );
    final linkStyle = context.textStyle.bodySmall?.copyWith(
      color: context.colors.onSurface,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
    );

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: prefix),
          TextSpan(
            text: termsLabel,
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = onTermsTap,
          ),
          const TextSpan(text: ', '),
          TextSpan(
            text: privacyLabel,
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = onPrivacyTap,
          ),
          TextSpan(text: andLabel),
          TextSpan(
            text: cookieLabel,
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = onCookieTap,
          ),
        ],
      ),
    );
  }
}
