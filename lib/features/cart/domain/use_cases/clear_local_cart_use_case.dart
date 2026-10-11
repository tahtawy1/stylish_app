import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/domain/repositories/cart_repository.dart';

class ClearLocalCartUseCase {
  final CartRepository repo;
  ClearLocalCartUseCase({required this.repo});

  Future<Either<Failure, void>> call() async {
    return await repo.clearLocalCart();
  }
}
