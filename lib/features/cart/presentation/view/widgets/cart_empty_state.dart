import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';

class CartEmptyState extends StatelessWidget {
  const CartEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: context.isDarkMode ? AppColors.grey2 : AppColors.grey10,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 48,
              color: context.isDarkMode ? AppColors.grey5 : AppColors.grey8,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Your cart is empty',
            style: context.textStyle.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to get started',
            style: context.textStyle.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
