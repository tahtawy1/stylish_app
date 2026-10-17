import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/order/domain/entities/order_entity.dart';
import 'package:stylish_app/features/order/domain/repositories/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository repo;

  CreateOrderUseCase({required this.repo});

  Future<Either<Failure, OrderEntity>> call({
    required String userId,
    required List<CartItemWithProductEntity> cartItems,
    double shippingFee = 80.0,
  }) async {
    return await repo.createOrder(
      userId: userId,
      cartItems: cartItems,
      shippingFee: shippingFee,
    );
  }
}
