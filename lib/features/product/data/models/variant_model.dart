import 'package:stylish_app/features/product/domain/entities/variant_entity.dart';

class VariantModel extends VariantEntity {
  VariantModel({
    required super.id,
    required super.color,
    required super.size,
    required super.price,
    required super.quantity,
    required super.isAvailable,
    required super.images,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      id: json['id'],
      color: json['color'],
      size: json['size'],
      price: json['price'],
      quantity: json['quantity'],
      isAvailable: json['isAvailable'],
      images: json['images'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color,
      'size': size,
      'price': price,
      'quantity': quantity,
      'isAvailable': isAvailable,
      'images': images,
    };
  }
}
