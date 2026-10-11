import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/network/image_placeholder.dart';
import 'package:stylish_app/core/theme/app_colors.dart';

class CartItemImage extends StatelessWidget {
  const CartItemImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 80,
        height: 80,
        color: context.isDarkMode ? AppColors.grey3 : AppColors.grey10,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          imageBuilder: (context, imageProvider) => Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: imageProvider,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ],
          ),
          errorWidget: (_, _, _) => const ImagePlaceholder(),
          placeholder: (_, _) => const ImagePlaceholder(),
        ),
      ),
    );
  }
}
