import 'package:stylish_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class CartItemWithProductEntity {
  final ProductEntity product;
  final CartItemEntity item;

  CartItemWithProductEntity({required this.product, required this.item});

  /// Returns available stock for the variant and size of this cart item.
  int? get stock {
    final variant = product.colorVariants
        .where((v) => v.id == item.variantId)
        .firstOrNull;

    if (variant == null) return null;

    final sizeVariant = variant.sizes
        .where((s) => s.size == item.size)
        .firstOrNull;

    return sizeVariant?.quantity;
  }

  /// Whether quantity can be incremented (quantity < stock).
  bool get canIncrement {
    final s = stock;
    if (s == null) return true;
    return item.quantity < s;
  }

  /// Whether quantity can be decremented (minimum allowed quantity is 1).
  bool get canDecrement {
    return item.quantity > 1;
  }

  factory CartItemWithProductEntity.fake() {
    return CartItemWithProductEntity(
      product: ProductEntity.fake(),
      item: CartItemEntity.fake(),
    );
  }
}
