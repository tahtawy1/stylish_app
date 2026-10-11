import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/cart/presentation/view/widgets/cart_item_card.dart';
import 'package:stylish_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';

class CheckoutItemsSection extends StatelessWidget {
  const CheckoutItemsSection({
    super.key,
    required this.cartItemsWithProducts,
  });

  final List<CartItemWithProductEntity> cartItemsWithProducts;

  @override
  Widget build(BuildContext context) {
    if (cartItemsWithProducts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            'Your cart is empty',
            style: context.textStyle.bodyMedium?.copyWith(
              color: const Color(0xFF999999),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Items',
              style: context.textStyle.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF171717),
              ),
            ),
            Text(
              '${cartItemsWithProducts.length} ${cartItemsWithProducts.length == 1 ? 'item' : 'items'}',
              style: context.textStyle.bodySmall?.copyWith(
                color: const Color(0xFF999999),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cartItemsWithProducts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = cartItemsWithProducts[index];
            return CartItemCard(
              cartItemWithProduct: item,
              onIncrement: () => context.read<CartCubit>().incrementItem(item),
              onDecrement: () => context.read<CartCubit>().decrementItem(item),
              onDelete: () => context.read<CartCubit>().removeItem(item),
            );
          },
        ),
        const SizedBox(height: 20),
        const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
      ],
    );
  }
}
