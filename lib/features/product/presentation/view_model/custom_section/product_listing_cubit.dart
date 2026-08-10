import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/category/domain/use_cases/get_category_by_id_use_case.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_best_sellers_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_new_arrivals_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_on_sale_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_products_by_category_use_case.dart';

part 'product_listing_state.dart';

enum ProductListingType {
  newArrivals,
  onSale,
  bestSellers,
  category;

  String get title {
    switch (this) {
      case ProductListingType.newArrivals:
        return 'New Arrivals';
      case ProductListingType.onSale:
        return 'On Sale';
      case ProductListingType.bestSellers:
        return 'Best Sellers';
      case ProductListingType.category:
        return 'Category';
    }
  }
}

class ProductListingCubit extends Cubit<ProductListingState> {
  ProductListingCubit({
    required this.getNewArrivalsProductsUseCase,
    required this.getBestSellersProductsUseCase,
    required this.getOnSaleProductsUseCase,
    required this.getProductsByCategoryUseCase,
    required this.getCategoryByIdUseCase,
  }) : super(const ProductListingState());

  final GetNewArrivalsProductsUseCase getNewArrivalsProductsUseCase;
  final GetBestSellersProductsUseCase getBestSellersProductsUseCase;
  final GetOnSaleProductsUseCase getOnSaleProductsUseCase;
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;
  final GetCategoryByIdUseCase getCategoryByIdUseCase;

  Future<void> load({
    required ProductListingType type,
    int limit = 20,
    String? categoryId,
  }) async {
    emit(
      state.copyWith(
        status: ProductListingStatus.loading,
        type: type,
        categoryId: categoryId,
        categoryName: null,
        products: [],
        lastDocument: null,
        hasMore: true,
        errorMessage: null,
      ),
    );

    if (type == ProductListingType.category && categoryId != null) {
      final categoryResult = await getCategoryByIdUseCase.call(id: categoryId);
      categoryResult.fold(
        (failure) {},
        (category) {
          if (!isClosed) {
            emit(state.copyWith(categoryName: category.name));
          }
        },
      );
    }

    final result = await _getProducts(type: type, limit: limit);

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ProductListingStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            status: ProductListingStatus.success,
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
    if (state.status == ProductListingStatus.loading) return;
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
    required ProductListingType type,
    required int limit,
    dynamic lastDocument,
  }) {
    switch (type) {
      case ProductListingType.newArrivals:
        return getNewArrivalsProductsUseCase.call(
          limit: limit,
          lastDocument: lastDocument,
        );

      case ProductListingType.bestSellers:
        return getBestSellersProductsUseCase.call(
          limit: limit,
          lastDocument: lastDocument,
        );

      case ProductListingType.onSale:
        return getOnSaleProductsUseCase.call(
          limit: limit,
          lastDocument: lastDocument,
        );
      case ProductListingType.category:
        return getProductsByCategoryUseCase.call(
          categoryId: state.categoryId!,
          limit: limit,
          lastDocument: lastDocument,
        );
    }
  }
}
