import 'package:stylish_app/features/product/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.id,
    required super.productId,
    required super.userId,
    required super.rating,
    required super.comment,
    required super.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      productId: json['productId'],
      userId: json['userId'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
    };
  }
}
