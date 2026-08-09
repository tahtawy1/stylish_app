import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/di/service_locator.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:stylish_app/features/home/presentation/widgets/best_sellers_section/best_sellers_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/categories_section/categories_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/custom_header.dart';
import 'package:stylish_app/features/home/presentation/widgets/greeting_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/hero_section/hero_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/new_arrivals_section/new_arrivals_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/on_sale_section/on_sale_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/search_section/search_section.dart';
import 'package:stylish_app/features/product/presentation/view_model/custom_section/custom_section_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _onProductTap(BuildContext context, String productId) {
    context.push('/product_details', extra: productId);
  }

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 20);
    return BlocProvider<HomeCubit>(
      create: (context) => getIt<HomeCubit>()..loadHome(),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: padding, child: GreetingSection()),
              const SizedBox(height: 20),
              const Padding(padding: padding, child: SearchSection()),
              const SizedBox(height: 20),
              const HeroSection(),
              const SizedBox(height: 20),
              Padding(
                padding: padding,
                child: CustomHeader(
                  title: context.l10n.categories,
                  onTap: () {
                    context.push('/categories');
                  },
                ),
              ),
              const SizedBox(height: 10),
              const CategoriesSection(),
              const SizedBox(height: 24),
              Padding(
                padding: padding,
                child: CustomHeader(
                  title: context.l10n.newArrivals,
                  onTap: () {
                    context.push(
                      '/custom_section',
                      extra: CustomSectionType.newArrivals,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              NewArrivalsSection(
                onProductTap: (productId) => _onProductTap(context, productId),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: padding,
                child: CustomHeader(
                  title: context.l10n.bestSellers,
                  onTap: () {
                    context.push(
                      '/custom_section',
                      extra: CustomSectionType.bestSellers,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              BestSellersSection(
                onProductTap: (productId) => _onProductTap(context, productId),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: padding,
                child: CustomHeader(
                  title: context.l10n.onSale,
                  onTap: () {
                    context.push(
                      '/custom_section',
                      extra: CustomSectionType.onSale,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              OnSaleSection(
                onProductTap: (productId) => _onProductTap(context, productId),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
