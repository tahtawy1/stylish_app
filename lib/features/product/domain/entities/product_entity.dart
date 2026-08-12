import 'package:stylish_app/features/product/domain/entities/color_variant_entity.dart';

class ProductEntity {
  final String id;
  final String sku;
  final String title;
  final String description;

  final String categoryId;
  final String material;
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
    required this.sku,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.material,
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
    sku: '0',
    title: 'Stylish Sample Product Name',
    description: 'Stylish Sample Product Description',
    categoryId: '0',
    material: 'Cotton',
    price: 99.99,
    discountPercentage: 0,
    totalSales: 100,
    averageRating: 4.5,
    reviewCount: 20,
    isAvailable: true,
    images: const [],
    colorVariants: const [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
