import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/category/domain/entities/category_entity.dart';
import 'package:stylish_app/features/category/domain/use_cases/get_categories_use_case.dart';
import 'package:stylish_app/features/hero/domain/entities/hero_section_entity.dart';
import 'package:stylish_app/features/hero/domain/use_cases/get_hero_sections_use_case.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_best_sellers_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_new_arrivals_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_on_sale_products_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.getHeroSectionsUseCase,
    required this.getCategoriesUseCase,
    required this.getNewArrivalsProductsUseCase,
    required this.getBestSellersProductsUseCase,
    required this.getOnSaleProductsUseCase,
  }) : super(const HomeState());

  final GetHeroSectionsUseCase getHeroSectionsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetNewArrivalsProductsUseCase getNewArrivalsProductsUseCase;
  final GetBestSellersProductsUseCase getBestSellersProductsUseCase;
  final GetOnSaleProductsUseCase getOnSaleProductsUseCase;
  Future<void> loadHome() async {
    emit(state.copyWith(status: HomeStatus.loading));

    final results = await Future.wait<Either<Failure, dynamic>>([
      getHeroSectionsUseCase(),
      getCategoriesUseCase(),
      getNewArrivalsProductsUseCase(limit: 5),
      getBestSellersProductsUseCase(limit: 5),
      getOnSaleProductsUseCase(limit: 5),
    ]);

    final heroResult = results[0] as Either<Failure, List<HeroSectionEntity>>;
    final categoryResult = results[1] as Either<Failure, List<CategoryEntity>>;
    final newArrivalsResult =
        results[2] as Either<Failure, List<ProductEntity>>;
    final bestSellersResult =
        results[3] as Either<Failure, List<ProductEntity>>;
    final onSaleResult = results[4] as Either<Failure, List<ProductEntity>>;
    String? error;
    List<HeroSectionEntity> heroes = [];
    List<CategoryEntity> categories = [];
    List<ProductEntity> newArrivals = [];
    List<ProductEntity> bestSellers = [];
    List<ProductEntity> onSale = [];

    heroResult.fold(
      (failure) => error = failure.message,
      (data) => heroes = data,
    );

    if (error != null) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: error));
      return;
    }

    categoryResult.fold(
      (failure) => error = failure.message,
      (data) => categories = data,
    );

    if (error != null) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: error));
      return;
    }

    newArrivalsResult.fold(
      (failure) => error = failure.message,
      (data) => newArrivals = data,
    );

    if (error != null) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: error));
      return;
    }

    bestSellersResult.fold(
      (failure) => error = failure.message,
      (data) => bestSellers = data,
    );

    if (error != null) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: error));
      return;
    }

    onSaleResult.fold(
      (failure) => error = failure.message,
      (data) => onSale = data,
    );

    if (error != null) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: error));
      return;
    }

    emit(
      state.copyWith(
        status: HomeStatus.success,
        heroes: heroes,
        categories: categories,
        newArrivals: newArrivals,
        bestSellers: bestSellers,
        onSaleProducts: onSale,
      ),
    );
  }
}
