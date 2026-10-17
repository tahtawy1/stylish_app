import 'package:stylish_app/features/order/domain/entities/order_item_entity.dart';

class OrderEntity {
  final String orderId;
  final String userId;
  final List<OrderItemEntity> items;
  final double subtotal;
  final double shippingFee;
  final double totalPrice;
  final String status;
  final DateTime createdAt;

  const OrderEntity({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.shippingFee,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });
}
