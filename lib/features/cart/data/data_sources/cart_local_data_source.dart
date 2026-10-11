import 'package:stylish_app/features/cart/data/models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<void> addToCart(CartItemModel cartItem);
  Future<List<CartItemModel>> getCartItems();
  Future<void> incrementCartItemQuantity({required String itemId});
  Future<void> decrementCartItemQuantity({required String itemId});
  Future<void> removeFromCart({required String itemId});
  Future<void> clearCart();
}
