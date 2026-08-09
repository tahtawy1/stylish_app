class VariantEntity {
  final String id;

  final String? color;
  final String? size;

  final int quantity;

  final bool isAvailable;

  final List<String> images;

  VariantEntity({
    required this.id,
    required this.color,
    required this.size,
    required this.quantity,
    required this.isAvailable,
    required this.images,
  });
}
