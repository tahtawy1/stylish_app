import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/utils/auth_guard.dart';
import 'package:stylish_app/features/favorite/presentation/view_model/favorite_cubit/favorite_cubit.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/presentation/view_model/product_details_cubit/product_details_cubit.dart';
import 'package:stylish_app/features/product/presentation/widgets/product_bottom_bar.dart';
import 'package:stylish_app/features/product/presentation/widgets/product_image_carousel.dart';
import 'package:stylish_app/features/product/presentation/widgets/product_info_section.dart';
import 'package:stylish_app/features/product/presentation/widgets/product_variant_selector.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productId,
    this.isFavorite = false,
  });

  final String productId;
  final bool isFavorite;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsCubit>().load(id: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final isLoading = state.status == ProductDetailsStatus.loading;
        final product = state.product;

        final productBone = ProductEntity.fake();
        return Scaffold(
          backgroundColor: context.colors.surface,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Skeletonizer(
                  enabled: isLoading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      BlocBuilder<FavoriteCubit, FavoriteState>(
                        builder: (context, favState) {
                          final isFav = favState.isFavorite(widget.productId);
                          return ProductImageCarousel(
                            images: isLoading
                                ? productBone.images
                                : (state.images?.isNotEmpty == true
                                      ? state.images!
                                      : productBone.images),
                            isFavorite: isFav,
                            onFavoriteTap: () {
                              final isAuthenticated = AuthGuard.requireAuth(
                                context,
                                action: LoginRequiredAction.favorites,
                              );
                              if (!isAuthenticated) return;
                              context.read<FavoriteCubit>().toggleFavorite(
                                productId: widget.productId,
                                isFavorite: isFav,
                              );
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Product Information (Title, Rating, Description)
                      ProductInfoSection(
                        product: isLoading
                            ? productBone
                            : state.product ?? productBone,
                        onReviewsTap: () {
                          final isAuthenticated = AuthGuard.requireAuth(
                            context,
                            action: LoginRequiredAction.reviews,
                          );
                          if (!isAuthenticated) return;
                          final product = state.product ?? productBone;
                          context.push(
                            '/product_reviews',
                            extra: {
                              'productId': widget.productId,
                              'averageRating': product.averageRating,
                              'totalRatings': product.ratingCount,
                              'totalReviewsWithComments':
                                  product.totalReviewsWithComments,
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Variant Selector (Color & Size)
                      ProductVariantSelector(
                        colorVariants: isLoading
                            ? []
                            : (state.colorVariants ?? []),
                        sizes: isLoading ? [] : state.availableSizes,
                        selectedColorVariant: state.selectedColorVariant,
                        selectedSizeVariant: state.selectedSizeVariant,
                        onColorVariantSelected: (colorVariant) {
                          context
                              .read<ProductDetailsCubit>()
                              .selectColorVariant(colorVariant);
                        },
                        onSizeVariantSelected: (sizeVariant) {
                          context.read<ProductDetailsCubit>().selectSizeVariant(
                            sizeVariant,
                          );
                        },
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: ProductBottomBar(
            isLoading: isLoading,
            product: isLoading ? productBone : product ?? productBone,
            onAddToCart: () {},
          ),
        );
      },
    );
  }
}
