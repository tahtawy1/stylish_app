import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class ProductInfoSection extends StatefulWidget {
  const ProductInfoSection({
    super.key,
    required this.product,
    this.onReviewsTap,
  });

  final ProductEntity product;
  final VoidCallback? onReviewsTap;

  @override
  State<ProductInfoSection> createState() => _ProductInfoSectionState();
}

class _ProductInfoSectionState extends State<ProductInfoSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Action Icon Row
        Text(product.title, style: context.textStyle.headlineLarge?.copyWith()),

        const SizedBox(height: 8),

        // Rating & Reviews Row
        GestureDetector(
          onTap: widget.onReviewsTap,
          child: Row(
            children: [
              const Icon(
                Icons.star_rounded,
                size: 20,
                color: Color(0xFFFFC107), // todo: app color
              ),
              const SizedBox(width: 4),
              Text(
                product.averageRating.toStringAsFixed(1),
                style: context.textStyle.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '(${product.reviewCount} ${context.l10n.reviews})',
                style: context.textStyle.bodyMedium?.copyWith(
                  color: const Color(0xFF64B5F6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Description
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: RichText(
            text: TextSpan(
              style: context.textStyle.bodyMedium?.copyWith(
                color: AppColors.grey5,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: _isExpanded
                      ? product.description
                      : (product.description.length > 110
                            ? '${product.description.substring(0, 110)} '
                            : product.description),
                ),
                if (!_isExpanded && product.description.length > 110)
                  TextSpan(
                    text: ' ${context.l10n.readMore}',
                    style: context.textStyle.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colors.onSurface,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
