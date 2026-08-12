import 'package:flutter/material.dart';
import 'package:stylish_app/core/network/image_placeholder.dart';

class ProductBone extends StatelessWidget {
  const ProductBone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: const ImagePlaceholder(),
    );
  }
}
