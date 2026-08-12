import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/utils/auth_guard.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/presentation/view_model/custom_section/product_listing_cubit.dart';
import 'package:stylish_app/features/product/presentation/widgets/product_card.dart';
import 'package:stylish_app/features/product/presentation/widgets/product_filter_sheet.dart';

class ProductListingView extends StatefulWidget {
  const ProductListingView({
    super.key,
    required this.type,
    this.id,
    required this.name,
  });

  final String name;
  final ProductListingType type;
  final String? id;
  @override
  State<ProductListingView> createState() => _ProductListingViewState();
}

class _ProductListingViewState extends State<ProductListingView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductListingCubit>().load(
        type: widget.type,
        categoryId: widget.id,
      );
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 500) {
      context.read<ProductListingCubit>().loadMore();
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
        title: BlocBuilder<ProductListingCubit, ProductListingState>(
          builder: (context, state) {
            final isLoading =
                state.status == ProductListingStatus.loading ||
                state.status == ProductListingStatus.initial;

            return Text(widget.name, style: context.textStyle.titleLarge);
          },
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
        actions: [
          BlocBuilder<ProductListingCubit, ProductListingState>(
            builder: (context, state) {
              final hasActiveFilter =
                  state.activeFilter?.hasActiveFilter ?? false;
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final filter = await ProductFilterSheet.show(
                          context,
                          initialFilter: state.activeFilter,
                        );
                        if (filter != null && context.mounted) {
                          context.read<ProductListingCubit>().applyFilter(
                            filter.hasActiveFilter ? filter : null,
                          );
                        }
                      },
                      icon: Icon(Icons.tune, color: context.colors.primary),
                    ),
                    if (hasActiveFilter)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: context.colors.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<ProductListingCubit, ProductListingState>(
            builder: (context, state) {
              final isLoading =
                  state.status == ProductListingStatus.loading ||
                  state.status == ProductListingStatus.initial;

              final isFailure = state.status == ProductListingStatus.failure;
              final products = isLoading
                  ? List.generate(6, (_) => ProductEntity.fake())
                  : state.products ?? [];

              if (isFailure && products.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      state.errorMessage ?? 'Something went wrong',
                      style: context.textStyle.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } // todo: Fetch products

              if (!isLoading && products.isEmpty) {
                return Center(
                  child: Text(
                    context.l10n.noProducts,
                    style: context.textStyle.bodyLarge,
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<ProductListingCubit>().load(
                    type: widget.type,
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
                              onFavTap: () {
                                final isAuthenticated = AuthGuard.requireAuth(
                                  context,
                                  action: LoginRequiredAction.favorites,
                                );
                                if (!isAuthenticated) return;
                                //TODO add favorite logic
                              },
                            );
                          },
                        ),
                        if (state.isLoadingMore)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                              child: SizedBox(
                                height: 25,
                                width: 25,
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
