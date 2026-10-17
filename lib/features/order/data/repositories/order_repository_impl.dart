import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/exceptions.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:stylish_app/features/order/domain/entities/order_entity.dart';
import 'package:stylish_app/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final CartLocalDataSource cartLocalDataSource;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.cartLocalDataSource,
  });

  @override
  Future<Either<Failure, OrderEntity>> createOrder({
    required String userId,
    required List<CartItemWithProductEntity> cartItems,
    double shippingFee = 80.0,
  }) async {
    try {
      final order = await remoteDataSource.createOrder(
        userId: userId,
        cartItems: cartItems,
        shippingFee: shippingFee,
      );

      // Clear local Hive cart after order is successfully placed
      await cartLocalDataSource.clearCart();

      return right(order);
    } on InsufficientStockException catch (e) {
      return left(
        InsufficientStockFailure(
          productTitle: e.productTitle,
          message: e.message,
        ),
      );
    } on AuthException catch (e) {
      return left(AuthFailure(code: e.code, message: e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getMyOrders({
    required String userId,
  }) async {
    try {
      final orders = await remoteDataSource.getMyOrders(userId: userId);
      return right(orders);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
