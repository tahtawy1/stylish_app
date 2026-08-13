abstract class FavoriteRemoteDataSource {
  Future<void> addToFavorite({required String productId});
  Future<void> removeFavorite({required String productId});
  Future<Set<String>> getUserFavoriteProductsIds();
}
