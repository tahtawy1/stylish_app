class ProductEntity {
  final String id;
  final String title;
  final String category;
  final double price;
  final double rating;
  final String image;
  final bool isFavorite;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.image,
    this.isFavorite = false,
  });
}
