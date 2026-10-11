class CartItemEntity {
  final String id;
  final String productId;
  final String variantId;
  final String size;
  final int quantity;

  CartItemEntity({
    required this.productId,
    required this.variantId,
    required this.size,
    required this.quantity,
  }) : id = '$productId-$variantId-$size';

  factory CartItemEntity.fake() {
    return CartItemEntity(
      productId: 'fake-product-id',
      variantId: 'fake-variant-id',
      size: 'S',
      quantity: 1,
    );
  }
}
