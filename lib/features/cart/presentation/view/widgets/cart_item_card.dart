import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/cart/presentation/view/widgets/cart_item_image.dart';
import 'package:stylish_app/features/cart/presentation/view/widgets/cart_item_info.dart';
import 'package:stylish_app/features/cart/presentation/view/widgets/cart_quantity_selector.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    this.onIncrement,
    this.onDecrement,
    this.onDelete,
    required this.cartItemWithProduct,
  });

  final CartItemWithProductEntity cartItemWithProduct;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CartItemImage(
                imageUrl:
                    cartItemWithProduct.product.images.firstOrNull ?? '',
              ),
              const SizedBox(width: 12),
              // Product Details
              Expanded(
                child: CartItemInfo(
                  size: cartItemWithProduct.item.size,
                  product: cartItemWithProduct.product,
                ),
              ),
              CartQuantitySelector(
                quantity: cartItemWithProduct.item.quantity,
                onIncrement:
                    cartItemWithProduct.canIncrement ? onIncrement : null,
                onDecrement:
                    cartItemWithProduct.canDecrement ? onDecrement : null,
              ),
            ],
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: onDelete,
            child: Icon(
              Icons.close,
              size: 18,
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
