import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class CheckoutDeliverySection extends StatelessWidget {
  const CheckoutDeliverySection({super.key});

  @override
  Widget build(BuildContext context) {
    final secondaryTextStyle = context.textStyle.bodyMedium?.copyWith(
      color: const Color(0xFF999999),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Delivery Address',
              style: context.textStyle.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF171717),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Change',
                style: context.textStyle.bodySmall?.copyWith(
                  color: const Color(0xFF171717),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF171717),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 20,
              color: Color(0xFF171717),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Home',
                    style: context.textStyle.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF171717),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '925 S Chugach St #APT 10, Alaska 99645',
                    style: secondaryTextStyle?.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
      ],
    );
  }
}
