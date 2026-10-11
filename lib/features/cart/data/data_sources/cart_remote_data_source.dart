import 'package:stylish_app/features/cart/data/models/cart_item_model.dart';

abstract class CartRemoteDataSource {
  Future<void> addToCart({required CartItemModel item, required String userId});
  Future<List<CartItemModel>> getCartItems({required String userId});
  Future<void> incrementCartItemQuantity({
    required String userId,
    required String itemId,
  });
  Future<void> decrementCartItemQuantity({
    required String userId,
    required String itemId,
  });
  Future<void> removeFromCart({required String userId, required String itemId});
}
