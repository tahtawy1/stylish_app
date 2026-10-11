part of 'cart_cubit.dart';

enum CartStatus { initial, loading, loaded, error }

class CartState {
  final CartStatus status;
  final List<CartItemWithProductEntity> cartItemsWithProducts;
  final String? errorMessage;
  final String? userMessage;
  final double subtotal;

  const CartState({
    this.status = CartStatus.initial,
    this.cartItemsWithProducts = const [],
    this.errorMessage,
    this.userMessage,
    this.subtotal = 0,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartItemWithProductEntity>? cartItemsWithProducts,
    String? errorMessage,
    String? userMessage,
    bool resetUserMessage = false,
    double? subtotal,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItemsWithProducts:
          cartItemsWithProducts ?? this.cartItemsWithProducts,
      errorMessage: errorMessage ?? this.errorMessage,
      userMessage: resetUserMessage ? null : (userMessage ?? this.userMessage),
      subtotal: subtotal ?? this.subtotal,
    );
  }
}
