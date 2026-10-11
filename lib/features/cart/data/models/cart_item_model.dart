import 'package:hive/hive.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_entity.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends CartItemEntity {
  @HiveField(0)
  @override
  String get id => super.id;

  @HiveField(1)
  @override
  String get productId => super.productId;

  @HiveField(2)
  @override
  String get variantId => super.variantId;

  @HiveField(3)
  @override
  String get size => super.size;

  @HiveField(4)
  @override
  int get quantity => super.quantity;

  CartItemModel({
    required super.productId,
    required super.variantId,
    required super.size,
    required super.quantity,
  });

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      productId: entity.productId,
      variantId: entity.variantId,
      size: entity.size,
      quantity: entity.quantity,
    );
  }

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? variantId,
    String? size,
    int? quantity,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'variant_id': variantId,
      'size': size,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['product_id'],
      variantId: json['variant_id'],
      size: json['size'],
      quantity: json['quantity'],
    );
  }
}
