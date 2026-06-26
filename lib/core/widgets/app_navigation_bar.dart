import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Theme.of(context).colorScheme.surfaceContainer,
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow,
            offset: const Offset(0, -15),
            blurRadius: 25,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_filled,
            onTap: () {
              onTap(0);
            },
            selected: currentIndex == 0,
            context: context,
          ),
          _buildNavItem(
            icon: Icons.shopping_bag_rounded,
            onTap: () {
              onTap(1);
            },
            selected: currentIndex == 1,
            context: context,
          ),
          _buildNavItem(
            icon: Icons.favorite_rounded,
            onTap: () {
              onTap(2);
            },
            selected: currentIndex == 2,
            context: context,
          ),
          _buildNavItem(
            icon: Icons.person_rounded,
            onTap: () {
              onTap(3);
            },
            selected: currentIndex == 3,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required VoidCallback onTap,
    required bool selected,
    required BuildContext context,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? AppColors.grey9.withAlpha(100)
                  : AppColors.grey2,
              shape: BoxShape.circle,
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: selected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                if (selected)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.onPrimary,
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
