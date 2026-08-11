import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/widgets/app_button.dart';

enum LoginRequiredAction {
  favorites,
  checkout,
  orders,
  reviews;

  String message() {
    switch (this) {
      case LoginRequiredAction.favorites:
        return 'Sign in to save your favorite products and keep them close.';

      case LoginRequiredAction.checkout:
        return 'Sign in to complete your order and make your purchase.';

      case LoginRequiredAction.orders:
        return 'Sign in to view your orders and keep track of your purchases.';

      case LoginRequiredAction.reviews:
        return 'Sign in to share your experience and leave a review.';
    }
  }
}

void showLoginRequiredBottomSheet(
  BuildContext context, {
  LoginRequiredAction action = LoginRequiredAction.favorites,
  String? customMessage,
}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) =>
        LoginRequiredBottomSheet(action: action, customMessage: customMessage),
  );
}

class LoginRequiredBottomSheet extends StatelessWidget {
  const LoginRequiredBottomSheet({
    super.key,
    this.action = LoginRequiredAction.favorites,
    this.customMessage,
  });

  final LoginRequiredAction action;
  final String? customMessage;

  @override
  Widget build(BuildContext context) {
    final message = customMessage ?? action.message();

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colors.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Lock icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              size: 30,
              color: context.colors.primary,
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text('Login Required', style: context.textStyle.titleLarge),
          const SizedBox(height: 10),

          // Message
          Text(
            message,
            style: context.textStyle.bodyMedium?.copyWith(
              color: context.colors.onSurface,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),

          // Sign In button
          AppButton(
            title: 'Sign In',
            onPressed: () {
              Navigator.of(context).pop();
              context.push('/login');
            },
          ),
          const SizedBox(height: 12),

          // Cancel text button
          SizedBox(
            width: double.infinity,

            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: context.textStyle.bodyMedium?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
