import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:stylish_app/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:stylish_app/features/cart/data/models/cart_item_model.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:stylish_app/features/product/data/data_sources/product_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;
  final CartRemoteDataSource remoteDataSource;
  final ProductRemoteDataSource productDataSource;

  CartRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.productDataSource,
  });

  @override
  Future<Either<Failure, void>> addToCart({
    required CartItemModel item,
    String? userId,
  }) async {
    try {
      if (userId == null || userId.isEmpty) {
        await localDataSource.addToCart(item);
      } else {
        await remoteDataSource.addToCart(item: item, userId: userId);
      }
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToLocalCart(CartItemModel item) async {
    try {
      await localDataSource.addToCart(item);
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToRemoteCart({
    required CartItemModel item,
    required String userId,
  }) async {
    try {
      await remoteDataSource.addToCart(item: item, userId: userId);
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItemWithProductEntity>>>
  getCartItemsWithProducts({String? userId}) async {
    try {
      final List<CartItemModel> items = (userId == null || userId.isEmpty)
          ? await localDataSource.getCartItems()
          : await remoteDataSource.getCartItems(userId: userId);

      if (items.isEmpty) {
        return right([]);
      }

      final ids = items.map((item) => item.productId).toSet().toList();
      final products = await productDataSource.getProductsByIds(ids: ids);

      final cartItemsWithProducts = <CartItemWithProductEntity>[];
      for (final item in items) {
        final product = products.where((p) => p.id == item.productId).firstOrNull;
        if (product != null) {
          cartItemsWithProducts.add(
            CartItemWithProductEntity(item: item, product: product),
          );
        }
      }

      return right(cartItemsWithProducts);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> incrementCartItem({
    required String itemId,
    String? userId,
  }) async {
    try {
      if (userId == null || userId.isEmpty) {
        await localDataSource.incrementCartItemQuantity(itemId: itemId);
      } else {
        await remoteDataSource.incrementCartItemQuantity(
          userId: userId,
          itemId: itemId,
        );
      }
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> decrementCartItem({
    required String itemId,
    String? userId,
  }) async {
    try {
      if (userId == null || userId.isEmpty) {
        await localDataSource.decrementCartItemQuantity(itemId: itemId);
      } else {
        await remoteDataSource.decrementCartItemQuantity(
          userId: userId,
          itemId: itemId,
        );
      }
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart({
    required String itemId,
    String? userId,
  }) async {
    try {
      if (userId == null || userId.isEmpty) {
        await localDataSource.removeFromCart(itemId: itemId);
      } else {
        await remoteDataSource.removeFromCart(userId: userId, itemId: itemId);
      }
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearLocalCart() async {
    try {
      await localDataSource.clearCart();
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
