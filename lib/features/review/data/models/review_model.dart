import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/review/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.id,
    // required super.productId,
    required super.userId,
    required super.rating,
    super.comment,
    super.userName,
    required super.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      // productId: json['productId'],
      userId: json['userId'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      userName: json['userName'],
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'productId': productId,
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'userName': userName,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
