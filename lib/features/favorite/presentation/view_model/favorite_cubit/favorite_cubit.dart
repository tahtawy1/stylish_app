import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/favorite/domain/use_cases/add_to_favorite_use_case.dart';
import 'package:stylish_app/features/favorite/domain/use_cases/get_user_favorite_products_ids_use_case.dart';
import 'package:stylish_app/features/favorite/domain/use_cases/remove_favorite_use_case.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({
    required this.addToFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.getUserFavoriteProductIdsUseCase,
  }) : super(const FavoriteState());
  final AddToFavoriteUseCase addToFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final GetUserFavoriteProductIdsUseCase getUserFavoriteProductIdsUseCase;

  Future<void> getUserFavoriteProductsIds() async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final result = await getUserFavoriteProductIdsUseCase.call();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: FavoriteStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (productIds) {
        emit(
          state.copyWith(
            status: FavoriteStatus.success,
            productIds: productIds,
          ),
        );
      },
    );
  }

  Future<void> toggleFavorite({
    required String productId,
    required bool isFavorite,
  }) async {
    final oldProductIds = Set<String>.from(state.productIds);
    final newProductIds = Set<String>.from(oldProductIds);

    if (isFavorite) {
      newProductIds.remove(productId);
    } else {
      newProductIds.add(productId);
    }

    // Optimistic UI
    emit(
      state.copyWith(
        status: FavoriteStatus.success,
        productIds: newProductIds,
        errorMessage: null,
      ),
    );

    final result = isFavorite
        ? await removeFavoriteUseCase.call(productId: productId)
        : await addToFavoriteUseCase.call(productId: productId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: FavoriteStatus.error,
            productIds: oldProductIds,
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        log(isFavorite ? 'remove success' : 'add success');
      },
    );
  }

  bool isFavorite(String productId) {
    return state.productIds.contains(productId);
  }
}
