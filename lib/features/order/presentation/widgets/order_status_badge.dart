import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (label, bgColor, textColor) = _getStatusStyle(context, status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: context.textStyle.bodySmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  (String, Color, Color) _getStatusStyle(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return (
          context.l10n.orderProcessing,
          const Color(0xFFE0F2FE),
          const Color(0xFF0369A1),
        );
      case 'shipped':
        return (
          context.l10n.orderShipped,
          const Color(0xFFFEF3C7),
          const Color(0xFFB45309),
        );
      case 'delivered':
        return (
          context.l10n.orderDelivered,
          const Color(0xFFDCFCE7),
          const Color(0xFF15803D),
        );
      case 'cancelled':
        return (
          context.l10n.orderCancelled,
          const Color(0xFFFEE2E2),
          const Color(0xFFB91C1C),
        );
      case 'pending':
      default:
        return (
          context.l10n.orderPending,
          const Color(0xFFF3F4F6),
          const Color(0xFF4B5563),
        );
    }
  }
}
