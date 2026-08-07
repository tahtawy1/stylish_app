import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.grey10.withValues(alpha: .5)),
      child: Text(
        context.l10n.appName,
        style: context.textStyle.headlineLarge?.copyWith(
          color: AppColors.grey7,
        ),
      ),
    );
  }
}
