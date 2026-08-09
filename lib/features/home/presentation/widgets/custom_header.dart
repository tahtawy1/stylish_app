import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.title,
    required this.onTap,
    this.inDetailsView = false,
  });
  final String title;
  final VoidCallback onTap;
  final bool inDetailsView;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textStyle.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        const Spacer(),
        inDetailsView
            ? const SizedBox()
            : GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Text(
                      context.l10n.seeMore,
                      style: context.textStyle.bodySmall,
                    ),
                    const SizedBox(width: 1),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: context.colors.primary,
                      size: 12,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
