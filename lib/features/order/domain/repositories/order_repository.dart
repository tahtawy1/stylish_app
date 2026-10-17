import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/order/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderEntity>> createOrder({
    required String userId,
    required List<CartItemWithProductEntity> cartItems,
    double shippingFee = 80.0,
  });

  Future<Either<Failure, List<OrderEntity>>> getMyOrders({
    required String userId,
  });
}
