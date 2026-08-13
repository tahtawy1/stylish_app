import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/features/favorite/presentation/view_model/favorite_cubit/favorite_cubit.dart';
import 'package:stylish_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/presentation/widgets/product_card.dart';

class OnSaleSection extends StatelessWidget {
  final Function(String) onProductTap;
  final Function(String) onFavTap;

  const OnSaleSection({
    super.key,
    required this.onProductTap,
    required this.onFavTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final isLoading = state.status == HomeStatus.loading;
        final List<ProductEntity> products = isLoading
            ? List.generate(5, (index) => ProductEntity.fake())
            : state.onSaleProducts;
        return SizedBox(
          height: 270,
          child: Skeletonizer(
            enabled: isLoading,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, favState) {
                    return ProductCard(
                      product: product,
                      leftMargin: index == 0 ? 20 : 8,
                      rightMargin: index == products.length - 1 ? 20 : 8,
                      onProductTap: onProductTap,
                      onFavTap: onFavTap,
                      isFavorite: favState.isFavorite(product.id),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
