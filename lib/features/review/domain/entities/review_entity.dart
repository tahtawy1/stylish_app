class ReviewEntity {
  final String id;

  // final String productId;
  final String userId;

  final double rating;
  final String? comment;

  final String? userName;
  final DateTime createdAt;

  ReviewEntity({
    required this.id,
    // required this.productId,
    required this.userId,
    required this.rating,
    this.comment,
    this.userName,
    required this.createdAt,
  });

  factory ReviewEntity.fake() {
    return ReviewEntity(
      id: '1',
      // productId: '000000000',
      userId: '1',
      userName: 'Wade Warren',
      rating: 5.0,
      comment:
          'The Item is very good, my son likes it very much and plays every day.',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
    );
  }

  static List<ReviewEntity> fakeList() {
    return [
      ReviewEntity(
        id: '1',
        // productId: 'p1',
        userId: 'u1',
        userName: 'Wade Warren',
        rating: 5.0,
        comment:
            'The Item is very good, my son likes it very much and plays every day.',
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
      ),
      ReviewEntity(
        id: '2',
        // productId: 'p1',
        userId: 'u2',
        userName: 'Guy Hawkins',
        rating: 4.0,
        comment:
            'The seller is very fast in sending packet, I just bought it and the item arrived in just 1 day!',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      ReviewEntity(
        id: '3',
        // productId: 'p1',
        userId: 'u3',
        userName: 'Robert Fox',
        rating: 4.0,
        comment:
            'I just bought it and the stuff is really good! I highly recommend it!',
        createdAt: DateTime.now().subtract(const Duration(days: 14)),
      ),
      ReviewEntity(
        id: '4',
        // productId: 'p1',
        userId: 'u4',
        userName: 'Esther Howard',
        rating: 4.0,
        comment: 'Great quality and fast delivery. Would buy again.',
        createdAt: DateTime.now().subtract(const Duration(days: 21)),
      ),
    ];
  }
}
