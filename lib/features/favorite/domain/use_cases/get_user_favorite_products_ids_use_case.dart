import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/favorite/domain/repositories/favorite_repository.dart';

class GetUserFavoriteProductIdsUseCase {
  final FavoriteRepository repository;
  GetUserFavoriteProductIdsUseCase({required this.repository});
  Future<Either<Failure, Set<String>>> call() async {
    return await repository.getUserFavoriteProductsIds();
  }
}
