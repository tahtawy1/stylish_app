import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class CheckoutSummaryRow extends StatelessWidget {
  const CheckoutSummaryRow({
    super.key,
    required this.label,
    required this.amount,
  });

  final String label;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.textStyle.bodyMedium?.copyWith(
              color: const Color(0xFF999999),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            amount,
            style: context.textStyle.bodyMedium?.copyWith(
              color: const Color(0xFF171717),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
