part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  final HomeStatus status;
  final List<HeroSectionEntity> heroes;
  final List<CategoryEntity> categories;
  final List<ProductEntity> newArrivals;
  final List<ProductEntity> highRatedProducts;
  final List<ProductEntity> bestSellers;
  final List<ProductEntity> onSaleProducts;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.heroes = const [],
    this.categories = const [],
    this.newArrivals = const [],
    this.highRatedProducts = const [],
    this.bestSellers = const [],
    this.onSaleProducts = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<HeroSectionEntity>? heroes,
    List<CategoryEntity>? categories,
    List<ProductEntity>? newArrivals,
    List<ProductEntity>? highRatedProducts,
    List<ProductEntity>? bestSellers,
    List<ProductEntity>? onSaleProducts,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      heroes: heroes ?? this.heroes,
      categories: categories ?? this.categories,
      newArrivals: newArrivals ?? this.newArrivals,
      highRatedProducts: highRatedProducts ?? this.highRatedProducts,
      bestSellers: bestSellers ?? this.bestSellers,
      onSaleProducts: onSaleProducts ?? this.onSaleProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
