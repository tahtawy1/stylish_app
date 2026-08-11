import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/product/data/models/color_variant_model.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.sku,
    required super.title,
    required super.description,
    required super.categoryId,
    required super.material,
    required super.price,
    required super.discountPercentage,
    required super.totalSales,
    required super.averageRating,
    required super.reviewCount,
    required super.isAvailable,
    required super.images,
    required super.colorVariants,
    super.collectionId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      material: json['material'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      totalSales: (json['totalSales'] as num?)?.toInt() ?? 0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      isAvailable: json['isAvailable'] as bool? ?? true,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      colorVariants:
          (json['colorVariants'] as List<dynamic>?)
              ?.map(
                (e) => ColorVariantModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      collectionId: json['collectionId'] as String?,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is Timestamp
                ? (json['createdAt'] as Timestamp).toDate()
                : DateTime.tryParse(json['createdAt'].toString()) ??
                      DateTime.now())
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is Timestamp
                ? (json['updatedAt'] as Timestamp).toDate()
                : DateTime.tryParse(json['updatedAt'].toString()) ??
                      DateTime.now())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sku': sku,
      'title': title,
      'description': description,
      'categoryId': categoryId,
      'material': material,
      'price': price,
      'discountPercentage': discountPercentage,
      'totalSales': totalSales,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
      'isAvailable': isAvailable,
      'images': images,
      'colorVariants': colorVariants
          .map(
            (cv) => ColorVariantModel(
              id: cv.id,
              color: cv.color,
              images: cv.images,
              sizes: cv.sizes,
            ).toJson(),
          )
          .toList(),
      'collectionId': collectionId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
