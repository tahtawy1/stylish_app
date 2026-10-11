import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/features/home/presentation/widgets/price_widget.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class CartItemInfo extends StatelessWidget {
  const CartItemInfo({super.key, required this.size, required this.product});

  final ProductEntity product;
  final String size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textStyle.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Size: $size',
          style: context.textStyle.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        if (product.discountPercentage != null &&
            product.discountPercentage! > 0)
          Row(
            children: [
              PriceWidget(price: product.finalPrice, isNewPrice: true),
              const SizedBox(width: 6),
              PriceWidget(price: product.price, isOldPrice: true),
            ],
          )
        else
          PriceWidget(price: product.price),
      ],
    );
  }
}
