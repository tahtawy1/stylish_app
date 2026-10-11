part of 'favorites_cubit.dart';

enum FavoritesStatus { initial, loading, success, error }

final class FavoritesState {
  final FavoritesStatus status;
  final List<ProductEntity> products;
  final String? errorMessage;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.products = const [],
    this.errorMessage,
  });

  bool get isLoading =>
      status == FavoritesStatus.initial || status == FavoritesStatus.loading;
  bool get isSuccess => status == FavoritesStatus.success;
  bool get isError => status == FavoritesStatus.error;

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<ProductEntity>? products,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
