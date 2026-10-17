class OrderItemEntity {
  final String productId;
  final String productTitle;
  final String imageUrl;
  final String variantId;
  final String color;
  final String size;
  final double unitPrice;
  final int quantity;
  final double totalPrice;

  const OrderItemEntity({
    required this.productId,
    required this.productTitle,
    required this.imageUrl,
    required this.variantId,
    required this.color,
    required this.size,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
  });
}
