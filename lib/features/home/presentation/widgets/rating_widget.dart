import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFC107)),
        const SizedBox(width: 4),
        Text(
          product.averageRating.toStringAsFixed(1),
          style: context.textStyle.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colors.onSurface,
          ),
        ),
      ],
    );
  }
}
