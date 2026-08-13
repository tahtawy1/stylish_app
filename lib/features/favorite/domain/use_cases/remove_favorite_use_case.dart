import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/favorite/domain/repositories/favorite_repository.dart';

class RemoveFavoriteUseCase {
  final FavoriteRepository favoriteRepository;
  RemoveFavoriteUseCase({required this.favoriteRepository});
  Future<Either<Failure, void>> call({required String productId}) async {
    return await favoriteRepository.removeFavorite(productId: productId);
  }
}
