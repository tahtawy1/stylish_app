part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {}

class OnboardingSeen extends OnboardingState {}

class NavigateToAuth extends OnboardingState {}


class OnboardingError extends OnboardingState {
  final Failure failure;

  const OnboardingError(this.failure);

  @override
  List<Object> get props => [failure];
}
