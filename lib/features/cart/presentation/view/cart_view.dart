import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/cart/presentation/view/widgets/cart_app_bar.dart';
import 'package:stylish_app/features/cart/presentation/view/widgets/cart_checkout_bar.dart';
import 'package:stylish_app/features/cart/presentation/view/widgets/cart_empty_state.dart';
import 'package:stylish_app/features/cart/presentation/view/widgets/cart_item_list.dart';
import 'package:stylish_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state.status == CartStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == CartStatus.loading;
        final hasProducts = state.cartItemsWithProducts.isNotEmpty;
        final cartItemsWithProducts = isLoading
            ? List.generate(3, (_) => CartItemWithProductEntity.fake())
            : state.cartItemsWithProducts;

        return Scaffold(
          appBar: const CartAppBar(),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: state.status != CartStatus.initial && !isLoading && !hasProducts
                ? const CartEmptyState()
                : RefreshIndicator(
                    onRefresh: () => context.read<CartCubit>().fetchCartData(),
                    child: CartItemList(
                      cartItemsWithProducts: cartItemsWithProducts,
                      onIncrement: (item) =>
                          context.read<CartCubit>().incrementItem(item),
                      onDecrement: (item) =>
                          context.read<CartCubit>().decrementItem(item),
                      onDelete: (item) =>
                          context.read<CartCubit>().removeItem(item),
                      isLoading: isLoading,
                    ),
                  ),
          ),
          bottomNavigationBar: !isLoading && hasProducts
              ? CartCheckoutBar(
                  subtotal: state.subtotal,
                  isEnabled: true,
                  onCheckout: () {},
                )
              : null,
        );
      },
    );
  }
}
