import 'package:flutter/material.dart';
import 'package:stylish_app/features/home/data/data_sources/home_dummy_data.dart';
import 'package:stylish_app/features/home/presentation/widgets/greeting_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/products_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/search_section.dart';
import 'package:stylish_app/features/home/presentation/widgets/tags_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingSection(
                userName: 'Albert Stevano',
              ),
              SizedBox(height: 20),
              SearchSection(),
              SizedBox(height: 20),
              TagsSection(),
              SizedBox(height: 24),
              ProductsSection(
                products: HomeDummyData.products,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
