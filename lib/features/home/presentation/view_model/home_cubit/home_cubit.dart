import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/category/domain/entities/category_entity.dart';
import 'package:stylish_app/features/category/domain/use_cases/get_categories_use_case.dart';
import 'package:stylish_app/features/hero/domain/entities/hero_section_entity.dart';
import 'package:stylish_app/features/hero/domain/use_cases/get_hero_sections_use_case.dart';
import 'package:stylish_app/features/home/domain/entities/product_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.getHeroSectionsUseCase,
    required this.getCategoriesUseCase,
  }) : super(const HomeState());

  final GetHeroSectionsUseCase getHeroSectionsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  Future<void> loadHome() async {
    emit(state.copyWith(status: HomeStatus.loading));

    final results = await Future.wait<Either<Failure, dynamic>>([
      getHeroSectionsUseCase(),
      getCategoriesUseCase(),
    ]);

    final heroResult = results[0] as Either<Failure, List<HeroSectionEntity>>;
    final categoryResult = results[1] as Either<Failure, List<CategoryEntity>>;

    String? error;
    List<HeroSectionEntity> heroes = [];
    List<CategoryEntity> categories = [];

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

    emit(state.copyWith(
      status: HomeStatus.success,
      heroes: heroes,
      categories: categories,
    ));
  }
}
