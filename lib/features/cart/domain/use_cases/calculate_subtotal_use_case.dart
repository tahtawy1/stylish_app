import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';

class CalculateSubtotalUseCase {
  double call(List<CartItemWithProductEntity> cartItemsWithProducts) {
    double subtotal = 0;
    for (var item in cartItemsWithProducts) {
      subtotal += item.product.finalPrice * item.item.quantity;
    }
    return subtotal;
  }
}
