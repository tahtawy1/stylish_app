import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/features/auth/checkout/presentation/view/widgets/checkout_summary_row.dart';

class CheckoutOrderSummarySection extends StatelessWidget {
  const CheckoutOrderSummarySection({
    super.key,
    required this.subtotal,
    required this.shippingFee,
    required this.total,
  });

  final double subtotal;
  final double shippingFee;
  final double total;

  String _format(double value) {
    return '\$ ${value.toStringAsFixed(value % 1 == 0 ? 0 : 2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: context.textStyle.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF171717),
          ),
        ),
        const SizedBox(height: 12),
        CheckoutSummaryRow(label: 'Sub-total', amount: _format(subtotal)),
        CheckoutSummaryRow(label: 'Shipping fee', amount: _format(shippingFee)),
        const Divider(height: 24, thickness: 1, color: Color(0xFFEEEEEE)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: context.textStyle.bodyLarge?.copyWith(
                color: const Color(0xFF171717),
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              _format(total),
              style: context.textStyle.bodyLarge?.copyWith(
                color: const Color(0xFF171717),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
