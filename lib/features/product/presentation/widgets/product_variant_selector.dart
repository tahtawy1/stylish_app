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
    required this.requireSize,
    required this.quantity,
    this.onQuantityIncrement,
    this.onQuantityDecrement,
  });

  final List<ColorVariantEntity> colorVariants;
  final List<SizeVariantEntity> sizes;
  final ColorVariantEntity? selectedColorVariant;
  final SizeVariantEntity? selectedSizeVariant;
  final ValueChanged<ColorVariantEntity>? onColorVariantSelected;
  final ValueChanged<SizeVariantEntity>? onSizeVariantSelected;
  final bool requireSize;
  final int quantity;
  final VoidCallback? onQuantityIncrement;
  final VoidCallback? onQuantityDecrement;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.chooseSize,
                    style: context.textStyle.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colors.onSurface,
                    ),
                  ),
                  if (requireSize) ...[
                    Text(
                      context.l10n.required,
                      style: context.textStyle.bodySmall?.copyWith(
                        color: context.colors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: sizes.map((sizeVariant) {
                  final isSelected = selectedSizeVariant?.id == sizeVariant.id;
                  final isAvailable =
                      sizeVariant.isAvailable && sizeVariant.quantity > 0;

                  return GestureDetector(
                    onTap: isAvailable
                        ? () => onSizeVariantSelected?.call(sizeVariant)
                        : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isAvailable
                            ? (context.isDarkMode
                                ? AppColors.grey3
                                : AppColors.grey9)
                            : isSelected
                            ? context.colors.primary
                            : context.colors.surface,
                        border: Border.all(
                          color: !isAvailable
                              ? Colors.transparent
                              : isSelected
                              ? context.colors.primary
                              : context.colors.outline.withValues(alpha: 0.5),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        sizeVariant.size,
                        style: context.textStyle.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: !isAvailable
                              ? TextDecoration.lineThrough
                              : null,
                          color: !isAvailable
                              ? (context.isDarkMode
                                  ? AppColors.grey5
                                  : AppColors.grey7)
                              : isSelected
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
              const SizedBox(height: 20),

              // Quantity Section
              Text(
                context.l10n.quantity,
                style: context.textStyle.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              QuantitySelector(
                onQuantityDecrement: onQuantityDecrement,
                quantity: quantity,
                onQuantityIncrement: onQuantityIncrement,
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

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.onQuantityDecrement,
    required this.quantity,
    required this.onQuantityIncrement,
    this.smallWidget = false,
  });

  final VoidCallback? onQuantityDecrement;
  final int quantity;
  final VoidCallback? onQuantityIncrement;
  final bool smallWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onQuantityDecrement,
          child: Container(
            width: smallWidget ? 24 : 36,
            height: smallWidget ? 24 : 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.surface,
              border: Border.all(
                color: context.colors.outline.withValues(alpha: 0.5),
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.remove,
              size: 18,
              color: context.colors.onSurface,
            ),
          ),
        ),
        SizedBox(width: smallWidget ? 8 : 16),
        Text(
          '$quantity',
          style: context.textStyle.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
        SizedBox(width: smallWidget ? 8 : 16),
        GestureDetector(
          onTap: onQuantityIncrement,
          child: Container(
            width: smallWidget ? 24 : 36,
            height: smallWidget ? 24 : 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.surface,
              border: Border.all(
                color: context.colors.outline.withValues(alpha: 0.5),
              ),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.add, size: 18, color: context.colors.onSurface),
          ),
        ),
      ],
    );
  }
}
