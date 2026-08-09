import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/features/home/presentation/widgets/product_card.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/presentation/view_model/custom_section/custom_section_cubit.dart';

class CustomSectionView extends StatefulWidget {
  const CustomSectionView({super.key, required this.sectionType});

  final CustomSectionType sectionType;

  @override
  State<CustomSectionView> createState() => _CustomSectionViewState();
}

class _CustomSectionViewState extends State<CustomSectionView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomSectionCubit>().load(type: widget.sectionType);
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 500) {
      context.read<CustomSectionCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.sectionType.title,
          style: context.textStyle.titleLarge,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CustomSectionCubit>().load(type: widget.sectionType);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<CustomSectionCubit, CustomSectionState>(
            builder: (context, state) {
              final isLoading =
                  state.status == CustomSectionStatus.loading ||
                  state.status == CustomSectionStatus.initial;

              final isFailure = state.status == CustomSectionStatus.failure;
              final products = isLoading
                  ? List.generate(6, (_) => ProductEntity.fake())
                  : state.products ?? [];

              if (isFailure && products.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage ?? 'Something went wrong',
                          style: context.textStyle.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CustomSectionCubit>().load(
                              type: widget.sectionType,
                            );
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (!isLoading && products.isEmpty) {
                return Center(
                  child: Text(
                    'No Products',
                    style: context.textStyle.bodyLarge,
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<CustomSectionCubit>().load(
                    type: widget.sectionType,
                  );
                },
                child: Skeletonizer(
                  enabled: isLoading,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        MasonryGridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 20,
                          itemCount: isLoading ? 6 : products.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              product: products[index],
                              onProductTap: (id) {
                                context.push(
                                  '/product_details',
                                  extra: products[index].id,
                                );
                              },
                              leftMargin: 0,
                              rightMargin: 0,
                            );
                          },
                        ),
                        if (state.isLoadingMore)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
