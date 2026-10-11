import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/cart/presentation/view/widgets/cart_item_card.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({
    super.key,
    required this.cartItemsWithProducts,
    this.onIncrement,
    this.onDecrement,
    this.onDelete,
    required this.isLoading,
  });

  final List<CartItemWithProductEntity> cartItemsWithProducts;
  final void Function(CartItemWithProductEntity cartItemWithProductEntity)?
  onIncrement;
  final void Function(CartItemWithProductEntity cartItemWithProductEntity)?
  onDecrement;
  final void Function(CartItemWithProductEntity cartItemWithProductEntity)?
  onDelete;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 24),
        itemCount: isLoading ? 3 : cartItemsWithProducts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final cartItem = cartItemsWithProducts[index];
          return CartItemCard(
            cartItemWithProduct: cartItem,
            onIncrement: onIncrement != null
                ? () => onIncrement!(cartItem)
                : null,
            onDecrement: onDecrement != null
                ? () => onDecrement!(cartItem)
                : null,
            onDelete: onDelete != null ? () => onDelete!(cartItem) : null,
          );
        },
      ),
    );
  }
}
