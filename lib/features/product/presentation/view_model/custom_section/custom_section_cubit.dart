import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_best_sellers_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_new_arrivals_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_on_sale_products_use_case.dart';

part 'custom_section_state.dart';

enum CustomSectionType {
  newArrivals,
  onSale,
  bestSellers;

  String get title {
    switch (this) {
      case CustomSectionType.newArrivals:
        return 'New Arrivals';
      case CustomSectionType.onSale:
        return 'On Sale';
      case CustomSectionType.bestSellers:
        return 'Best Sellers';
    }
  }
}

class CustomSectionCubit extends Cubit<CustomSectionState> {
  CustomSectionCubit({
    required this.getNewArrivalsProductsUseCase,
    required this.getBestSellersProductsUseCase,
    required this.getOnSaleProductsUseCase,
  }) : super(const CustomSectionState());

  final GetNewArrivalsProductsUseCase getNewArrivalsProductsUseCase;
  final GetBestSellersProductsUseCase getBestSellersProductsUseCase;
  final GetOnSaleProductsUseCase getOnSaleProductsUseCase;

  Future<void> load({required CustomSectionType type, int limit = 20}) async {
    emit(
      state.copyWith(
        status: CustomSectionStatus.loading,
        type: type,
        products: [],
        lastDocument: null,
        hasMore: true,
        errorMessage: null,
      ),
    );

    final result = await _getProducts(type: type, limit: limit);

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CustomSectionStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            status: CustomSectionStatus.success,
            products: data.items,
            lastDocument: data.lastDocument,
            hasMore: data.hasMore,
          ),
        );
        log('first load data: ${data.items.length}');
      },
    );
  }

  Future<void> loadMore({int limit = 20}) async {
    if (state.status == CustomSectionStatus.loading) return;
    if (state.isLoadingMore) return;
    if (!state.hasMore) return;
    if (state.type == null) return;
    if (state.lastDocument == null) return;

    emit(state.copyWith(isLoadingMore: true));
    log('load more .........');
    log(
      'TYPE: ${state.type} | '
      'LAST DOC: ${state.lastDocument?.id}',
    );

    final result = await _getProducts(
      type: state.type!,
      limit: limit,
      lastDocument: state.lastDocument,
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(isLoadingMore: false, errorMessage: failure.message),
        );
      },
      (data) {
        emit(
          state.copyWith(
            products: [...state.products ?? [], ...data.items],
            lastDocument: data.lastDocument,
            hasMore: data.hasMore,
            isLoadingMore: false,
          ),
        );
        log('data after loading ${data.items.length}');
      },
    );
  }

  Future _getProducts({
    required CustomSectionType type,
    required int limit,
    dynamic lastDocument,
  }) {
    switch (type) {
      case CustomSectionType.newArrivals:
        return getNewArrivalsProductsUseCase.call(
          limit: limit,
          lastDocument: lastDocument,
        );

      case CustomSectionType.bestSellers:
        return getBestSellersProductsUseCase.call(
          limit: limit,
          lastDocument: lastDocument,
        );

      case CustomSectionType.onSale:
        return getOnSaleProductsUseCase.call(
          limit: limit,
          lastDocument: lastDocument,
        );
    }
  }
}
