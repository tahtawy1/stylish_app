import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stylish_app/features/onboarding/domain/repositories/onboarding_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final OnboardingRepository onboardingRepository;

  SplashCubit({required this.onboardingRepository}) : super(SplashInitial());

  Future<void> checkAppRouting() async {
    final onboardingResult = await onboardingRepository.isOnboardingSeen();
    
    onboardingResult.fold(
      (failure) {
        emit(SplashNavigateToOnboarding());
      },
      (isSeen) {
        if (!isSeen) {
          emit(SplashNavigateToOnboarding());
        } else {
          // TODO: Check Auth feature here in the future
          // For now, default to navigate to Auth
          emit(SplashNavigateToAuth());
        }
      },
    );
  }
}
