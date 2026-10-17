import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/order/data/models/order_item_model.dart';
import 'package:stylish_app/features/order/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.orderId,
    required super.userId,
    required super.items,
    required super.subtotal,
    required super.shippingFee,
    required super.totalPrice,
    required super.status,
    required super.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map(
                (item) =>
                    OrderItemModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      shippingFee: (json['shippingFee'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'pending',
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : DateTime.tryParse(json['createdAt'].toString()) ??
                  DateTime.now())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'items': items
          .map(
            (item) => OrderItemModel(
              productId: item.productId,
              productTitle: item.productTitle,
              imageUrl: item.imageUrl,
              variantId: item.variantId,
              color: item.color,
              size: item.size,
              unitPrice: item.unitPrice,
              quantity: item.quantity,
              totalPrice: item.totalPrice,
            ).toJson(),
          )
          .toList(),
      'subtotal': subtotal,
      'shippingFee': shippingFee,
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
