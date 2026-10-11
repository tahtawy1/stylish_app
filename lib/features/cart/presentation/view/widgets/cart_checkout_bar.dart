import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/widgets/app_button.dart';

class CartCheckoutBar extends StatelessWidget {
  const CartCheckoutBar({
    super.key,
    required this.subtotal,
    this.onCheckout,
    this.isEnabled = true,
  });

  final double subtotal;
  final VoidCallback? onCheckout;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          top: BorderSide(
            color: context.colors.outline.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subtotal',
                  style: context.textStyle.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${context.l10n.poundSymbol} ${subtotal.toStringAsFixed(0)}',
                  style: context.textStyle.headlineMedium,
                ),
              ],
            ),

            const SizedBox(width: 24),

            // Checkout Button
            Expanded(
              child: AppButton(
                title: 'Checkout',
                postfixIcon: Icons.arrow_forward_rounded,
                onPressed: isEnabled ? onCheckout : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
