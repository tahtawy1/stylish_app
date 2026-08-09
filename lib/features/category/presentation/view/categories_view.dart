import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/network/image_placeholder.dart';
import 'package:stylish_app/core/widgets/circular_icon_button.dart';
import 'package:stylish_app/features/category/domain/entities/category_entity.dart';
import 'package:stylish_app/features/category/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:stylish_app/features/home/presentation/widgets/categories_section/categories_section.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.categories,
          style: context.textStyle.titleLarge,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            final isLoading =
                state.status == CategoryStatus.loading ||
                state.status == CategoryStatus.initial;

            final categories = state.categories ?? [];

            if (!isLoading && categories.isEmpty) {
              return const Center(child: Text('No Categories'));
            }

            return Skeletonizer(
              enabled: isLoading,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: isLoading ? 6 : categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    category: isLoading
                        ? CategoryEntity.fake()
                        : categories[index],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: category.imageUrl.isEmpty
          ? CategoryBone(category: category)
          : CachedNetworkImage(
              imageUrl: category.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              imageBuilder: (context, imageProvider) => Stack(
                alignment: Alignment.center,
                children: [
                  Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  CategoryInfo(categoryName: category.name),
                ],
              ),
              errorWidget: (_, _, _) => const ImagePlaceholder(),
              placeholder: (_, _) => const ImagePlaceholder(),
            ),
    );
  }
}
