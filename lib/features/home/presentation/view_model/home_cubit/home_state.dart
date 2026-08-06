part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  final HomeStatus status;
  final List<HeroSectionEntity> heroes;
  final List<CategoryEntity> categories;
  final List<ProductEntity> newArrivals;
  final List<ProductEntity> highRatedProducts;
  final List<ProductEntity> mostSalesProducts;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.heroes = const [],
    this.categories = const [],
    this.newArrivals = const [],
    this.highRatedProducts = const [],
    this.mostSalesProducts = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<HeroSectionEntity>? heroes,
    List<CategoryEntity>? categories,
    List<ProductEntity>? newArrivals,
    List<ProductEntity>? highRatedProducts,
    List<ProductEntity>? mostSalesProducts,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      heroes: heroes ?? this.heroes,
      categories: categories ?? this.categories,
      newArrivals: newArrivals ?? this.newArrivals,
      highRatedProducts: highRatedProducts ?? this.highRatedProducts,
      mostSalesProducts: mostSalesProducts ?? this.mostSalesProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

