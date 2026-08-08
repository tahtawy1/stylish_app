import 'package:stylish_app/features/product/domain/entities/color_variant_entity.dart';

class ProductEntity {
  final String id;
  final String title;
  final String description;

  final String categoryId;

  final double price;
  final double? discountPercentage;
  final int totalSales;
  final double averageRating;
  final int reviewCount;

  final bool isAvailable;

  final List<String> images;

  final List<ColorVariantEntity> colorVariants;
  final String? collectionId;

  final DateTime createdAt;
  final DateTime updatedAt;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.price,
    required this.discountPercentage,
    required this.totalSales,
    required this.averageRating,
    required this.reviewCount,
    required this.isAvailable,
    required this.images,
    required this.colorVariants,
    this.collectionId,
    required this.createdAt,
    required this.updatedAt,
  });

  double get finalPrice {
    if (discountPercentage == null || discountPercentage! <= 0) {
      return price;
    }
    return price - (price * discountPercentage! / 100);
  }

  factory ProductEntity.fake() => ProductEntity(
    id: '0',
    title: 'Product',
    description: 'Product',
    categoryId: '0',
    price: 0,
    discountPercentage: 0,
    totalSales: 0,
    averageRating: 0.0,
    reviewCount: 0,
    isAvailable: true,
    images: [],
    colorVariants: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
