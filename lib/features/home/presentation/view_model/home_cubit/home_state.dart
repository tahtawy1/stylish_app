part of 'home_cubit.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<HeroSectionEntity> heroSections;
  HomeLoaded({required this.heroSections});
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
