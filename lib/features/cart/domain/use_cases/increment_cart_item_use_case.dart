import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/domain/repositories/cart_repository.dart';

class IncrementCartItemUseCase {
  final CartRepository cartRepository;

  IncrementCartItemUseCase({required this.cartRepository});

  Future<Either<Failure, void>> call({
    required String itemId,
    String? userId,
  }) async {
    return await cartRepository.incrementCartItem(
      itemId: itemId,
      userId: userId,
    );
  }
}
