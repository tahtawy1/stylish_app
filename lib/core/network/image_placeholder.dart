import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.grey10.withValues(alpha: .5)),
      child: Text(
        context.l10n.appName,
        style: context.textStyle.headlineMedium?.copyWith(
          letterSpacing: 2,
          color: AppColors.grey8,
        ),
      ),
    );
  }

  static String? cardImageUrl(ProductEntity product) {
    if (product.colorVariants.isNotEmpty) {
      return product.colorVariants.first.images.firstOrNull;
    }
    return null;
  }
}
