import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/favorite/data/data_sources/favorite_remote_data_source.dart';
import 'package:stylish_app/features/favorite/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;
  FavoriteRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, void>> addToFavorite({
    required String productId,
  }) async {
    try {
      await remoteDataSource.addToFavorite(productId: productId);
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite({
    required String productId,
  }) async {
    try {
      await remoteDataSource.removeFavorite(productId: productId);
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Set<String>>> getUserFavoriteProductsIds() async {
    try {
      final productIds = await remoteDataSource.getUserFavoriteProductsIds();
      return right(productIds);
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: e.toString()));
    }
  }
}
