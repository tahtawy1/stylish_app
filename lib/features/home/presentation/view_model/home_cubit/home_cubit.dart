import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/hero/domain/entities/hero_section_entity.dart';
import 'package:stylish_app/features/hero/domain/use_cases/get_hero_sections_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.getHeroSectionsUseCase) : super(HomeInitial());
  final GetHeroSectionsUseCase getHeroSectionsUseCase;

  Future<void> getHeroSections() async {
    emit(HomeLoading());
    final result = await getHeroSectionsUseCase();
    result.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (heroSections) => emit(HomeLoaded(heroSections: heroSections)),
    );
  }
}
