import 'package:stylish_app/features/product/data/models/size_variant_model.dart';
import 'package:stylish_app/features/product/domain/entities/color_variant_entity.dart';

class ColorVariantModel extends ColorVariantEntity {
  const ColorVariantModel({
    required super.id,
    required super.color,
    required super.images,
    required super.sizes,
  });

  factory ColorVariantModel.fromJson(Map<String, dynamic> json) {
    return ColorVariantModel(
      id: json['id'] as String? ?? '',
      color: json['color'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      sizes: (json['sizes'] as List<dynamic>?)
              ?.map(
                (e) => SizeVariantModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color,
      'images': images,
      'sizes': sizes
          .map(
            (s) => SizeVariantModel(
              id: s.id,
              size: s.size,
              quantity: s.quantity,
              isAvailable: s.isAvailable,
            ).toJson(),
          )
          .toList(),
    };
  }
}
