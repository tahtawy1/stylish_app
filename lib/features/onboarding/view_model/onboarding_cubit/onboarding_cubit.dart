import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/onboarding/domain/repositories/onboarding_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository repository;

  OnboardingCubit({required this.repository}) : super(OnboardingInitial());

  Future<void> checkOnboardingStatus() async {
    final result = await repository.isOnboardingSeen();
    result.fold(
      (failure) => emit(OnboardingError(failure)),
      (isSeen) {
        if (isSeen) {
          emit(NavigateToAuth());
        } else {
          emit(OnboardingInitial());
        }
      },
    );
  }

  Future<void> saveOnboardingSeen() async {
    final result = await repository.saveOnboardingSeen();
    result.fold(
      (failure) => emit(OnboardingError(failure)),
      (_) => emit(OnboardingSeen()),
    );
  }
}
