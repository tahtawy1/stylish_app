import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/core/di/service_locator.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/utils/auth_guard.dart';
import 'package:stylish_app/features/favorite/presentation/view_model/favorite_cubit/favorite_cubit.dart';
import 'package:stylish_app/features/favorite/presentation/view_model/favorites_cubit/favorites_cubit.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/presentation/widgets/product_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FavoritesCubit>()..loadFavoriteProducts(),
      child: const _FavoritesBody(),
    );
  }
}

class _FavoritesBody extends StatelessWidget {
  const _FavoritesBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.favorites,
          style: context.textStyle.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state.isLoading) {
                return _ProductGrid(
                  products: List.generate(6, (_) => ProductEntity.fake()),
                  isLoading: true,
                );
              }

              if (state.isError) {}

              if (state.products.isEmpty) {
                return Center(
                  child: Text(
                    context.l10n.noProducts,
                    style: context.textStyle.bodyLarge,
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () =>
                    context.read<FavoritesCubit>().loadFavoriteProducts(),
                child: _ProductGrid(products: state.products, isLoading: false),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({required this.products, required this.isLoading});

  final List<ProductEntity> products;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: MasonryGridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: 16,
          crossAxisSpacing: 20,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, favState) {
                final isFav = favState.isFavorite(product.id);
                return ProductCard(
                  product: product,
                  leftMargin: 0,
                  rightMargin: 0,
                  isFavorite: isFav,
                  onProductTap: (id) =>
                      context.push('/product_details', extra: product.id),
                  onFavTap: (id) {
                    final isAuthenticated = AuthGuard.requireAuth(
                      context,
                      action: LoginRequiredAction.favorites,
                    );
                    if (!isAuthenticated) return;

                    context.read<FavoriteCubit>().toggleFavorite(
                      productId: product.id,
                      isFavorite: isFav,
                    );

                    // Remove from displayed list immediately when unfavoriting
                    if (isFav) {
                      context.read<FavoritesCubit>().removeProductFromView(
                        product.id,
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
