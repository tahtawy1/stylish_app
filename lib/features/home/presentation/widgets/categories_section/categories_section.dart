import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/network/image_placeholder.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/features/category/domain/entities/category_entity.dart';
import 'package:stylish_app/features/category/presentation/view/categories_view.dart';
import 'package:stylish_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, required this.onCategoryTap});

  final Function(String) onCategoryTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final isLoading = state.status == HomeStatus.loading;
        final categories = isLoading
            ? List.generate(5, (index) => CategoryEntity.fake())
            : state.categories;
        return SizedBox(
          height: 150,
          child: Skeletonizer(
            enabled: isLoading,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, index) => Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 20 : 8,
                  right: index == categories.length - 1 ? 20 : 8,
                ),
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: CategoryCard(
                    category: categories[index],
                    onCategoryTap: onCategoryTap,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CategoryBone extends StatelessWidget {
  const CategoryBone({required this.category, super.key});

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.grey10.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: CategoryInfo(categoryName: category.name, wantGradient: false),
    );
  }
}

class CategoryInfo extends StatelessWidget {
  const CategoryInfo({
    super.key,
    this.wantGradient = true,
    required this.categoryName,
  });

  final String categoryName;
  final bool wantGradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: wantGradient
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.grey1,
                  Colors.transparent,
                ],
              )
            : null,
      ),
      padding: const EdgeInsets.all(16),
      child: Text(
        textAlign: TextAlign.center,
        categoryName,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: context.textStyle.headlineMedium?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
