import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/domain/repositories/cart_repository.dart';

class DecrementCartItemUseCase {
  final CartRepository cartRepository;

  DecrementCartItemUseCase({required this.cartRepository});

  Future<Either<Failure, void>> call({
    required String itemId,
    String? userId,
  }) async {
    return await cartRepository.decrementCartItem(
      itemId: itemId,
      userId: userId,
    );
  }
}
