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
      id: json['id'],
      title: json['title'],
      description: json['description'],
      categoryId: json['categoryId'],
      price: json['price'],
      discountPercentage: json['discountPercentage'],
      averageRating: json['averageRating'],
      reviewCount: json['reviewCount'],
      isAvailable: json['isAvailable'],
      images: json['images'],
      variants: json['variants'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
      'variants': variants,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
