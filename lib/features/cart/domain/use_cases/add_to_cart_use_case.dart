import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/data/models/cart_item_model.dart';
import 'package:stylish_app/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository cartRepository;

  AddToCartUseCase({required this.cartRepository});

  Future<Either<Failure, void>> call({
    required CartItemModel item,
    String? userId,
  }) async {
    return await cartRepository.addToCart(item: item, userId: userId);
  }
}
