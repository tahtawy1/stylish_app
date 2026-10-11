import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/data/models/cart_item_model.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addToCart({
    required CartItemModel item,
    String? userId,
  });
  Future<Either<Failure, void>> addToLocalCart(CartItemModel item);
  Future<Either<Failure, void>> addToRemoteCart({
    required CartItemModel item,
    required String userId,
  });
  Future<Either<Failure, List<CartItemWithProductEntity>>>
  getCartItemsWithProducts({String? userId});
  Future<Either<Failure, void>> incrementCartItem({
    required String itemId,
    String? userId,
  });
  Future<Either<Failure, void>> decrementCartItem({
    required String itemId,
    String? userId,
  });
  Future<Either<Failure, void>> removeFromCart({
    required String itemId,
    String? userId,
  });
  Future<Either<Failure, void>> clearLocalCart();
}
