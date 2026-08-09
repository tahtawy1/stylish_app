import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.postfixIcon,
    this.onPressed,
    this.loading = false,
  });

  final String title;
  final IconData? postfixIcon;
  final bool loading;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onPressed,
      child: Container(
        height: 54,
        width: double.infinity,
        decoration: BoxDecoration(
          color: loading ? context.colors.outline : context.colors.primary,
          borderRadius: BorderRadius.circular(32),
        ),
        child: loading
            ? Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: context.colors.onPrimary,
                    backgroundColor: AppColors.bgIndicatorColor,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: context.textStyle.bodyMedium?.copyWith(
                      color: context.colors.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (postfixIcon != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8),
                      child: Icon(
                        postfixIcon,
                        color: context.colors.onPrimary,
                        size: 24,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
