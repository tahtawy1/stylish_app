import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/data/models/cart_item_model.dart';
import 'package:stylish_app/features/cart/domain/repositories/cart_repository.dart';

class AddToRemoteCartUseCase {
  final CartRepository cartRepository;

  AddToRemoteCartUseCase({required this.cartRepository});

  Future<Either<Failure, void>> call({
    required CartItemModel item,
    required String userId,
  }) async {
    return await cartRepository.addToRemoteCart(item: item, userId: userId);
  }
}
