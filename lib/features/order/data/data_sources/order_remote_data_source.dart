import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/order/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder({
    required String userId,
    required List<CartItemWithProductEntity> cartItems,
    double shippingFee = 80.0,
  });

  Future<List<OrderModel>> getMyOrders({required String userId});
}
