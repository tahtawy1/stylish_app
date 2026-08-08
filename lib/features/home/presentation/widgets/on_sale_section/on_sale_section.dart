import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:stylish_app/features/home/presentation/widgets/home_product_card.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class OnSaleSection extends StatelessWidget {
  final Function(String) onProductTap;

  const OnSaleSection({super.key, required this.onProductTap});

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
              itemBuilder: (_, index) => HomeProductCard(
                product: products[index],
                leftMargin: index == 0 ? 20 : 8,
                rightMargin: index == products.length - 1 ? 20 : 8,
                onProductTap: onProductTap,
              ),
            ),
          ),
        );
      },
    );
  }
}
