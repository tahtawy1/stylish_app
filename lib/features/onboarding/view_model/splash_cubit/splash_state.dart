part of 'splash_cubit.dart';

sealed class SplashState {
  const SplashState();
}

final class SplashInitial extends SplashState {}

class SplashNavigateToOnboarding extends SplashState {}

class SplashNavigateToAuth extends SplashState {}

class SplashNavigateToHome extends SplashState {}
