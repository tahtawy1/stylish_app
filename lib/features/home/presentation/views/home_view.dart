import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/di/service_locator.dart';
import 'package:stylish_app/features/home/data/data_sources/home_dummy_data.dart';
import 'package:stylish_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:stylish_app/features/home/presentation/widgets/greeting_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/hero_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/products_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/search_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/tags_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 20);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
              BlocProvider<HomeCubit>(
                create: (context) => getIt<HomeCubit>()..getHeroSections(),
                child: const HeroSection(),
              ),
              const SizedBox(height: 20),
              const Padding(padding: padding, child: TagsSection()),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ProductsSection(products: HomeDummyData.products),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

