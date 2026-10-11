import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/cart/domain/repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository repo;
  GetCartItemsUseCase({required this.repo});

  Future<Either<Failure, List<CartItemWithProductEntity>>> call({
    String? userId,
  }) async {
    return await repo.getCartItemsWithProducts(userId: userId);
  }
}
