import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/category/domain/entities/category_entity.dart';
import 'package:stylish_app/features/category/domain/use_cases/get_categories_use_case.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required this.getCategoriesUseCase})
    : super(const CategoryState());
  final GetCategoriesUseCase getCategoriesUseCase;
  void loadCategories() async {
    emit(state.copyWith(status: CategoryStatus.loading));
    final result = await getCategoriesUseCase.call();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CategoryStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (categories) => emit(
        state.copyWith(status: CategoryStatus.loaded, categories: categories),
      ),
    );
  }
}
