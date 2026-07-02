import 'package:flutter/material.dart';
import 'package:stylish_app/features/auth/presentation/widgets/shared/social_auth_button.dart';

/// Renders the Google + Facebook social auth buttons stacked vertically.
/// The [googleLabel] and [facebookLabel] strings come from the caller
/// so the same widget can be used for both "Login with…" and "Sign Up with…".
class AuthSocialButtons extends StatelessWidget {
  const AuthSocialButtons({
    super.key,
    required this.googleLabel,
    required this.facebookLabel,
    this.onGooglePressed,
    this.onFacebookPressed,
  });

  final String googleLabel;
  final String facebookLabel;
  final VoidCallback? onGooglePressed;
  final VoidCallback? onFacebookPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialAuthButton(
          label: googleLabel,
          iconPath: 'assets/images/google_icon.svg',
          onPressed: onGooglePressed,
        ),
        const SizedBox(height: 12),
        SocialAuthButton(
          label: facebookLabel,
          iconPath: 'assets/images/facebook_icon.svg',
          onPressed: onFacebookPressed,
          backgroundColor: const Color(0xFF1877F2),
          foregroundColor: Colors.white,
        ),
      ],
    );
  }
}
