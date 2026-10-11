import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/data/models/cart_item_model.dart';
import 'package:stylish_app/features/cart/domain/repositories/cart_repository.dart';

class AddToLocalCartUseCase {
  final CartRepository cartRepository;

  AddToLocalCartUseCase({required this.cartRepository});

  Future<Either<Failure, void>> call({required CartItemModel cartItem}) async {
    return await cartRepository.addToLocalCart(cartItem);
  }
}
