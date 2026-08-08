import 'package:stylish_app/features/product/domain/entities/size_variant_entity.dart';

class ColorVariantEntity {
  final String id;
  final String color;
  final List<String> images;
  final List<SizeVariantEntity> sizes;

  const ColorVariantEntity({
    required this.id,
    required this.color,
    required this.images,
    required this.sizes,
  });
}
