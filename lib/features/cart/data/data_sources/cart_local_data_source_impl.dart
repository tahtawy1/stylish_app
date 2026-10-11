import 'package:hive_flutter/hive_flutter.dart';
import 'package:stylish_app/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:stylish_app/features/cart/data/models/cart_item_model.dart';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartItemModel> cartBox;
  CartLocalDataSourceImpl({required this.cartBox});

  @override
  Future<void> addToCart(CartItemModel cartItem) async {
    try {
      if (cartBox.containsKey(cartItem.id)) {
        final item = cartBox.get(cartItem.id);
        if (item != null) {
          await cartBox.put(
            cartItem.id,
            item.copyWith(quantity: item.quantity + cartItem.quantity),
          );
        }
      } else {
        await cartBox.put(cartItem.id, cartItem);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      return cartBox.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> decrementCartItemQuantity({required String itemId}) async {
    try {
      final item = cartBox.get(itemId);
      if (item != null && item.quantity > 1) {
        await cartBox.put(itemId, item.copyWith(quantity: item.quantity - 1));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> incrementCartItemQuantity({required String itemId}) async {
    try {
      final item = cartBox.get(itemId);
      if (item != null) {
        await cartBox.put(itemId, item.copyWith(quantity: item.quantity + 1));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart({required String itemId}) async {
    try {
      await cartBox.delete(itemId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await cartBox.clear();
    } catch (e) {
      rethrow;
    }
  }
}
