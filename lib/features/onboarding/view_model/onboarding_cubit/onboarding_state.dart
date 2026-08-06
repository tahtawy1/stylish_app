part of 'onboarding_cubit.dart';

class OnboardingState {
  const OnboardingState();
}

final class OnboardingInitial extends OnboardingState {}

class OnboardingSeen extends OnboardingState {}

class NavigateToAuth extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final Failure failure;

  const OnboardingError(this.failure);
}
