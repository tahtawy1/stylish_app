import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/network/image_placeholder.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/features/home/presentation/widgets/price_widget.dart';
import 'package:stylish_app/features/home/presentation/widgets/rating_widget.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class HomeProductCard extends StatelessWidget {
  final ProductEntity product;
  final double leftMargin;
  final double rightMargin;

  const HomeProductCard({
    super.key,
    required this.product,
    required this.leftMargin,
    required this.rightMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftMargin, right: rightMargin),
      child: Stack(
        children: [
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    height: 180,
                    width: 180,
                    child: product.images.isEmpty
                        ? _ProductBone(product: product)
                        : CachedNetworkImage(
                            imageUrl: product.images.first,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => const ImagePlaceholder(),
                            errorWidget: (_, __, ___) =>
                                const ImagePlaceholder(),
                          ),
                  ),
                ),

                const SizedBox(height: 10),

                _ProductInfo(product: product),
              ],
            ),
          ),

          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? AppColors.grey2.withAlpha(200)
                      : AppColors.white.withAlpha(220),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite_border_rounded,
                  size: 18,
                  color: context.colors.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductBone extends StatelessWidget {
  const _ProductBone({required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline.withValues(alpha: .5)),
      ),
      child: const ImagePlaceholder(),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  const _ProductInfo({required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textStyle.titleMedium,
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            if (product.discountPercentage != null &&
                product.discountPercentage! > 0) ...[
              PriceWidget(price: product.price, isOldPrice: true),
              const SizedBox(width: 4),
              PriceWidget(price: product.finalPrice, isNewPrice: true),
            ] else ...[
              PriceWidget(price: product.price),
            ],
          ],
        ),

        const SizedBox(height: 8),

        RatingWidget(product: product),
      ],
    );
  }
}
