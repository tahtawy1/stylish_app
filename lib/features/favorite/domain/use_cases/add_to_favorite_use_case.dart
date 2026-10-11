import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/favorite/domain/repositories/favorite_repository.dart';

class AddToFavoriteUseCase {
  final FavoriteRepository favoriteRepository;
  AddToFavoriteUseCase({required this.favoriteRepository});
  Future<Either<Failure, void>> call({required String productId}) async {
    return await favoriteRepository.addToFavorite(productId: productId);
  }
}
