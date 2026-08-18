import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, void>> addToFavorite({required String productId});
  Future<Either<Failure, void>> removeFavorite({required String productId});
  Future<Either<Failure, Set<String>>> getUserFavoriteProductsIds();
}
