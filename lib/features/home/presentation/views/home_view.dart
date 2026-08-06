import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/di/service_locator.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/features/home/data/data_sources/home_dummy_data.dart';
import 'package:stylish_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:stylish_app/features/home/presentation/widgets/categories_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/custom_header.dart';
import 'package:stylish_app/features/home/presentation/widgets/greeting_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/hero_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/product_card.dart';
import 'package:stylish_app/features/home/presentation/widgets/search_section.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 20);
    return BlocProvider<HomeCubit>(
      create: (context) => getIt<HomeCubit>()..loadHome(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: padding,
                  child: GreetingSection(userName: 'Albert Stevano'),
                ),
                const SizedBox(height: 20),
                const Padding(padding: padding, child: SearchSection()),
                const SizedBox(height: 20),
                const HeroSection(),
                const SizedBox(height: 20),
                Padding(
                  padding: padding,
                  child: CustomHeader(
                    title: context.l10n.categories,
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 10),
                const CategoriesSection(),
                const SizedBox(height: 24),
                Padding(
                  padding: padding,
                  child: CustomHeader(
                    title: context.l10n.newArrivals,
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 10),
                const NewArrivalsSection(),
                // const Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: ProductsSection(products: HomeDummyData.products),
                // ),
                // const SizedBox(height: 45),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewArrivalsSection extends StatelessWidget {
  const NewArrivalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: HomeDummyData.products.length,
        itemBuilder: (_, index) => _HomeProductCard(
          product: HomeDummyData.products[index],
          leftMargin: index == 0 ? 20 : 8,
          rightMargin: index == HomeDummyData.products.length - 1 ? 20 : 8,
        ),
      ),
    );
  }
}

class _HomeProductCard extends StatelessWidget {
  final ProductEntity product;
  final double leftMargin;
  final double rightMargin;
  const _HomeProductCard({
    required this.product,
    required this.leftMargin,
    required this.rightMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftMargin, right: rightMargin),
      child: SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(product.images.first),
                  fit: BoxFit.cover,
                ),
              ),
              height: 180,
              width: 180,
            ),
            const SizedBox(height: 10),

            // Title
            Text(
              'product.titlekdsjdksjdskjdkdkjssdjkdjdsjd',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textStyle.titleMedium?.copyWith(
                // color: context.colors.onSurface,
              ),
            ),

            const SizedBox(height: 8),

            // Price & Rating Row
            Row(
              children: [
                if (product.discountPercentage != null &&
                    product.discountPercentage! > 0) ...[
                  PriceWidget(product: product, isOldPrice: true),
                  const SizedBox(width: 4),
                  PriceWidget(product: product, isNewPrice: true),
                ] else ...[
                  PriceWidget(product: product),
                ],

                // rating widget
                // const Spacer(),
              ],
            ),
            // SizedBox()
            Spacer(),

            RatingWidget(product: product),
          ],
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFC107)),
        const SizedBox(width: 4),
        Text(
          product.averageRating.toStringAsFixed(1),
          style: context.textStyle.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colors.onSurface,
          ),
        ),
      ],
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.product,
    this.isOldPrice = false,
    this.isNewPrice = false,
  });
  final bool isOldPrice;
  final bool isNewPrice;

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${context.l10n.poundSymbol} ${product.price.toStringAsFixed(0)}',
      style: isOldPrice
          ? context.textStyle.bodySmall?.copyWith(
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w900,
            )
          : context.textStyle.bodyMedium?.copyWith(
              color: isNewPrice ? context.colors.error : context.colors.primary,
              fontWeight: FontWeight.w900,
            ),
    );
  }
}
