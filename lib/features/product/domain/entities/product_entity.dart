import 'package:stylish_app/features/product/domain/entities/variant_entity.dart';

class ProductEntity {
  final String id;
  final String title;
  final String description;

  final String categoryId;

  final double price;
  final double? discountPercentage;

  final double averageRating;
  final int reviewCount;

  final bool isAvailable;

  final List<String> images;

  final List<VariantEntity> variants;

  final DateTime createdAt;
  final DateTime updatedAt;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.price,
    required this.discountPercentage,
    required this.averageRating,
    required this.reviewCount,
    required this.isAvailable,
    required this.images,
    required this.variants,
    required this.createdAt,
    required this.updatedAt,
  });
}
