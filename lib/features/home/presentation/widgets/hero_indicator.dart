import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';

class HeroIndicator extends StatelessWidget {
  const HeroIndicator({
    super.key,
    required this.heroesCount,
    required this.currentPage,
  });

  final int heroesCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(heroesCount, (index) {
        final isActive = currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 12 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isActive ? context.colors.primary : AppColors.grey7,
          ),
        );
      }),
    );
  }
}
