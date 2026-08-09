import 'package:stylish_app/features/product/domain/entities/variant_entity.dart';

class VariantModel extends VariantEntity {
  VariantModel({
    required super.id,
    required super.color,
    required super.size,
    required super.quantity,
    required super.isAvailable,
    required super.images,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      id: json['id'] ?? '',
      color: json['color'],
      size: json['size'],
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      isAvailable: json['isAvailable'] ?? true,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color,
      'size': size,
      'quantity': quantity,
      'isAvailable': isAvailable,
      'images': images,
    };
  }
}
