part of 'favorite_cubit.dart';

enum FavoriteStatus { initial, loading, success, error }

final class FavoriteState {
  final FavoriteStatus status;
  final String? errorMessage;
  final Set<String> productIds;

  const FavoriteState({
    this.status = FavoriteStatus.initial,
    this.errorMessage,
    this.productIds = const {},
  });

  FavoriteState copyWith({
    FavoriteStatus? status,
    String? errorMessage,
    Set<String>? productIds,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      productIds: productIds ?? this.productIds,
    );
  }

  bool isFavorite(String productId) => productIds.contains(productId);
}
