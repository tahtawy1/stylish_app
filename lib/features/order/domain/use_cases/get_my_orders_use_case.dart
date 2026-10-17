import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/order/domain/entities/order_entity.dart';
import 'package:stylish_app/features/order/domain/repositories/order_repository.dart';

class GetMyOrdersUseCase {
  final OrderRepository repo;

  GetMyOrdersUseCase({required this.repo});

  Future<Either<Failure, List<OrderEntity>>> call({
    required String userId,
  }) async {
    return await repo.getMyOrders(userId: userId);
  }
}
