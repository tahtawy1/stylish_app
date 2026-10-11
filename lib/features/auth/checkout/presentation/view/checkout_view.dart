import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/utils/auth_guard.dart';
import 'package:stylish_app/core/widgets/app_button.dart';
import 'package:stylish_app/features/auth/checkout/presentation/view/widgets/checkout_app_bar.dart';
import 'package:stylish_app/features/auth/checkout/presentation/view/widgets/checkout_delivery_section.dart';
import 'package:stylish_app/features/auth/checkout/presentation/view/widgets/checkout_items_section.dart';
import 'package:stylish_app/features/auth/checkout/presentation/view/widgets/checkout_order_summary_section.dart';
import 'package:stylish_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final allowed = AuthGuard.requireAuth(
        context,
        action: LoginRequiredAction.checkout,
      );
      if (!allowed && mounted) {
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const CheckoutAppBar(),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          final hasItems = cartState.cartItemsWithProducts.isNotEmpty;
          final subtotal = cartState.subtotal;
          const vat = 0.0;
          final shippingFee = hasItems ? 80.0 : 0.0;
          final total = hasItems ? (subtotal + vat + shippingFee) : 0.0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckoutItemsSection(
                        cartItemsWithProducts: cartState.cartItemsWithProducts,
                      ),
                      const SizedBox(height: 24),
                      const CheckoutDeliverySection(),
                      const SizedBox(height: 24),
                      CheckoutOrderSummarySection(
                        subtotal: subtotal,
                        shippingFee: shippingFee,
                        total: total,
                      ),
                    ],
                  ),
                ),
              ),
              // Place Order bottom button — sits above the system gesture bar
              SafeArea(
                top: false,
                minimum: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: SizedBox(
                  height: 48,
                  child: AppButton(title: 'Place Order', onPressed: () {}),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
