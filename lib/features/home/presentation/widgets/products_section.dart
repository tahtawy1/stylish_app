import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stylish_app/features/home/presentation/widgets/product_card.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({
    super.key,
    required this.products,
    this.onProductTap,
  });

  final List<ProductEntity> products;
  final ValueChanged<ProductEntity>? onProductTap;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      mainAxisSpacing: 24,
      crossAxisSpacing: 16,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(
          product: product,
          onProductTap: onProductTap,
          onFavoriteTap: () {},
        );
      },
    );
  }
}
