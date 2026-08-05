import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colors.primary,
        ),
        child: Icon(
          Icons.tune_rounded,
          color: context.colors.onPrimary,
          size: 22,
        ),
      ),
    );
  }
}
