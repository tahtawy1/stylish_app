import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/domain/use_cases/get_user_name_use_cases.dart';
import 'package:stylish_app/features/category/domain/entities/category_entity.dart';
import 'package:stylish_app/features/category/domain/use_cases/get_categories_use_case.dart';
import 'package:stylish_app/features/hero/domain/entities/hero_section_entity.dart';
import 'package:stylish_app/features/hero/domain/use_cases/get_hero_sections_use_case.dart';
import 'package:stylish_app/features/product/domain/entities/paginated_result.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_best_sellers_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_new_arrivals_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_on_sale_products_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.getUserNameUseCases,
    required this.getHeroSectionsUseCase,
    required this.getCategoriesUseCase,
    required this.getNewArrivalsProductsUseCase,
    required this.getBestSellersProductsUseCase,
    required this.getOnSaleProductsUseCase,
  }) : super(const HomeState());

  final GetUserNameUseCases getUserNameUseCases;
  final GetHeroSectionsUseCase getHeroSectionsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetNewArrivalsProductsUseCase getNewArrivalsProductsUseCase;
  final GetBestSellersProductsUseCase getBestSellersProductsUseCase;
  final GetOnSaleProductsUseCase getOnSaleProductsUseCase;
  Future<void> loadHome() async {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(status: HomeStatus.loading));

    final results = await Future.wait<Either<Failure, dynamic>>([
      getUserNameUseCases(),
      getHeroSectionsUseCase(),
      getCategoriesUseCase(),
      getNewArrivalsProductsUseCase(limit: 5),
      getBestSellersProductsUseCase(limit: 5),
      getOnSaleProductsUseCase(limit: 5),
    ]);

    final userNameResult = results[0] as Either<Failure, String>;
    final heroResult = results[1] as Either<Failure, List<HeroSectionEntity>>;
    final categoryResult = results[2] as Either<Failure, List<CategoryEntity>>;
    final newArrivalsResult = results[3] as Either<Failure, PaginatedResult>;
    final bestSellersResult = results[4] as Either<Failure, PaginatedResult>;
    final onSaleResult = results[5] as Either<Failure, PaginatedResult>;
    String? error;
    String userName = '';
    List<HeroSectionEntity> heroes = [];
    List<CategoryEntity> categories = [];
    List<ProductEntity> newArrivals = [];
    List<ProductEntity> bestSellers = [];
    List<ProductEntity> onSale = [];

    userNameResult.fold(
      (failure) => error = failure.message,
      (data) => userName = data,
    );
    if (error != null) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: error));
      return;
    }

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
      (data) => newArrivals = data.items as List<ProductEntity>,
    );

    if (error != null) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: error));
      return;
    }

    bestSellersResult.fold(
      (failure) => error = failure.message,
      (data) => bestSellers = data.items as List<ProductEntity>,
    );

    if (error != null) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: error));
      return;
    }

    onSaleResult.fold(
      (failure) => error = failure.message,
      (data) => onSale = data.items as List<ProductEntity>,
    );

    if (error != null) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: error));
      return;
    }

    emit(
      state.copyWith(
        status: HomeStatus.success,
        userName: userName,
        heroes: heroes,
        categories: categories,
        newArrivals: newArrivals,
        bestSellers: bestSellers,
        onSaleProducts: onSale,
      ),
    );
  }
}
