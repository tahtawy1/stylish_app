class ReviewEntity {
  final String id;

  final String productId;
  final String userId;

  final double rating;
  final String comment;

  final DateTime createdAt;

  ReviewEntity({
    required this.id,
    required this.productId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
}
