import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/product/data/models/variant_model.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.categoryId,
    required super.price,
    required super.discountPercentage,
    required super.averageRating,
    required super.reviewCount,
    required super.isAvailable,
    required super.images,
    required super.variants,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      isAvailable: json['isAvailable'] ?? true,
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      variants: (json['variants'] as List<dynamic>?)
              ?.map((e) => VariantModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now())
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : DateTime.tryParse(json['updatedAt'].toString()) ?? DateTime.now())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'categoryId': categoryId,
      'price': price,
      'discountPercentage': discountPercentage,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
      'isAvailable': isAvailable,
      'images': images,
      'variants': variants
          .map((v) => VariantModel(
                id: v.id,
                color: v.color,
                size: v.size,
                price: v.price,
                quantity: v.quantity,
                isAvailable: v.isAvailable,
                images: v.images,
              ).toJson())
          .toList(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
