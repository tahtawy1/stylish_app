import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class CartSummaryRow extends StatelessWidget {
  const CartSummaryRow({
    super.key,
    required this.label,
    required this.value,
    required this.currency,
  });

  final String label;
  final double value;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: context.textStyle.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Text(
          value == 0
              ? '\$0.00'
              : '$currency ${value.toStringAsFixed(2)}',
          style: context.textStyle.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: context.colors.onSurface,
          ),
        ),
      ],
    );
  }
}
