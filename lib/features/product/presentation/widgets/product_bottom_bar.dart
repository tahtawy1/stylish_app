import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/core/widgets/app_button.dart';
import 'package:stylish_app/features/home/presentation/widgets/price_widget.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({
    super.key,
    required this.product,
    this.onAddToCart,
    this.isLoading = false,
  });

  final ProductEntity product;
  final VoidCallback? onAddToCart;
  final bool isLoading;

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
            // Price Display
            Skeletonizer(
              enabled: isLoading,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.priceLabel,
                    style: context.textStyle.bodyMedium?.copyWith(
                      color: AppColors.grey5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (product.discountPercentage != null &&
                            product.discountPercentage! > 0) ...[
                          PriceWidget(price: product.price, isOldPrice: true),
                          const SizedBox(width: 4),
                          PriceWidget(
                            price: product.finalPrice,
                            isNewPrice: true,
                          ),
                        ] else
                          PriceWidget(price: product.finalPrice),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 24),

            // Add to Cart Button
            Expanded(
              child: AppButton(
                title: context.l10n.addToCart,
                postfixIcon: Icons.shopping_bag_outlined,
                onPressed: onAddToCart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
