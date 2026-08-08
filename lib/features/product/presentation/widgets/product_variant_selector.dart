import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/features/product/domain/entities/color_variant_entity.dart';
import 'package:stylish_app/features/product/domain/entities/size_variant_entity.dart';

class ProductVariantSelector extends StatelessWidget {
  const ProductVariantSelector({
    super.key,
    required this.colorVariants,
    required this.sizes,
    this.selectedColorVariant,
    this.selectedSizeVariant,
    this.onColorVariantSelected,
    this.onSizeVariantSelected,
  });

  final List<ColorVariantEntity> colorVariants;
  final List<SizeVariantEntity> sizes;
  final ColorVariantEntity? selectedColorVariant;
  final SizeVariantEntity? selectedSizeVariant;
  final ValueChanged<ColorVariantEntity>? onColorVariantSelected;
  final ValueChanged<SizeVariantEntity>? onSizeVariantSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Choose Size Section
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.chooseSize,
                style: context.textStyle.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: sizes.map((sizeVariant) {
                  final isSelected =
                      selectedSizeVariant?.id == sizeVariant.id;
                  return GestureDetector(
                    onTap: () => onSizeVariantSelected?.call(sizeVariant),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? context.colors.primary
                            : context.colors.surface,
                        border: Border.all(
                          color: isSelected
                              ? context.colors.primary
                              : context.colors.outline.withValues(alpha: 0.5),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        sizeVariant.size,
                        style: context.textStyle.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? context.colors.onPrimary
                              : context.colors.onSurface,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Color Section
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.color,
                style: context.textStyle.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: colorVariants.map((colorVariant) {
                  final isSelected =
                      selectedColorVariant?.id == colorVariant.id;
                  final swatchColor = _parseColor(colorVariant.color);

                  return GestureDetector(
                    onTap: () => onColorVariantSelected?.call(colorVariant),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 36,
                      height: 36,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? context.colors.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: swatchColor,
                          border: Border.all(
                            color: swatchColor == AppColors.white
                                ? AppColors.grey9
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _parseColor(String? colorStr) {
    if (colorStr == null || colorStr.isEmpty) return AppColors.grey5;
    final str = colorStr.toLowerCase().trim();
    switch (str) {
      case 'grey':
      case 'gray':
        return AppColors.grey5;
      case 'dark grey':
      case 'dark gray':
        return AppColors.grey2;
      case 'black':
        return AppColors.grey1;
      case 'white':
        return AppColors.white;
      case 'red':
        return AppColors.red;
      case 'green':
        return AppColors.green;
      case 'blue':
        return Colors.blue;
      case 'pink':
        return Colors.pink;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      case 'brown':
        return Colors.brown;
      case 'cyan':
        return Colors.cyan;
      case 'lime':
        return Colors.lime;
      case 'teal':
        return Colors.teal;
      case 'indigo':
        return Colors.indigo;
      case 'amber':
        return Colors.amber;
      case 'navy':
        return const Color(0xFF001F5B);
      case 'beige':
        return const Color(0xFFF5F0DC);
      case 'olive':
        return const Color(0xFF808000);
      case 'light blue':
        return Colors.lightBlue;
      case 'light green':
        return Colors.lightGreen;
      default:
        return AppColors.grey5;
    }
  }
}
