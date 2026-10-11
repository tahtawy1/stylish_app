import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/domain/repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository cartRepository;

  RemoveFromCartUseCase({required this.cartRepository});

  Future<Either<Failure, void>> call({
    required String itemId,
    String? userId,
  }) async {
    return await cartRepository.removeFromCart(
      itemId: itemId,
      userId: userId,
    );
  }
}
