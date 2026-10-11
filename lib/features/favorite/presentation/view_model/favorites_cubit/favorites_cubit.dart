import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/favorite/presentation/view_model/favorite_cubit/favorite_cubit.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_products_by_ids_use_case.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required this.getProductsByIdsUseCase,
    required this.favoriteCubit,
  }) : super(const FavoritesState()) {
    _favoriteSubscription = favoriteCubit.stream.listen((favState) {
      _syncFavorites(favState.productIds);
    });
  }

  final GetProductsByIdsUseCase getProductsByIdsUseCase;
  final FavoriteCubit favoriteCubit;
  StreamSubscription<FavoriteState>? _favoriteSubscription;

  void _syncFavorites(Set<String> currentFavIds) {
    if (state.status != FavoritesStatus.success) return;

    final updatedProducts = state.products
        .where((product) => currentFavIds.contains(product.id))
        .toList();

    final existingIds = updatedProducts.map((p) => p.id).toSet();
    final hasNewProducts = currentFavIds.any((id) => !existingIds.contains(id));

    if (hasNewProducts) {
      loadFavoriteProducts();
    } else if (updatedProducts.length != state.products.length) {
      emit(state.copyWith(products: updatedProducts));
    }
  }

  @override
  Future<void> close() {
    _favoriteSubscription?.cancel();
    return super.close();
  }

  Future<void> loadFavoriteProducts() async {
    final ids = favoriteCubit.state.productIds.toList();

    if (ids.isEmpty) {
      emit(const FavoritesState(status: FavoritesStatus.success, products: []));
      return;
    }

    emit(const FavoritesState(status: FavoritesStatus.loading));

    final result = await getProductsByIdsUseCase.call(ids: ids);

    result.fold(
      (failure) => emit(
        FavoritesState(
          status: FavoritesStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        FavoritesState(status: FavoritesStatus.success, products: products),
      ),
    );
  }

  /// Removes a single product from the displayed list immediately
  /// (called after the user unfavorites a product while inside FavoritesView).
  void removeProductFromView(String productId) {
    final updated =
        state.products.where((p) => p.id != productId).toList();
    emit(state.copyWith(products: updated));
  }
}
