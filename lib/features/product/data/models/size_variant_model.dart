import 'package:stylish_app/features/product/domain/entities/size_variant_entity.dart';

class SizeVariantModel extends SizeVariantEntity {
  const SizeVariantModel({
    required super.id,
    required super.size,
    required super.quantity,
    required super.isAvailable,
  });

  factory SizeVariantModel.fromJson(Map<String, dynamic> json) {
    return SizeVariantModel(
      id: json['id'] as String? ?? '',
      size: json['size'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'size': size,
      'quantity': quantity,
      'isAvailable': isAvailable,
    };
  }
}
