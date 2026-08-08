import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/network/image_placeholder.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/features/home/presentation/widgets/custom_indicator.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({
    super.key,
    required this.images,
    this.isFavorite = false,
    // this.onBackTap,
    this.onFavoriteTap,
  });

  final List<String> images;
  final bool isFavorite;
  // final VoidCallback? onBackTap;
  final VoidCallback? onFavoriteTap;

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;

    return Stack(
      children: [
        // Image carousel container
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SizedBox(
            height: 380,
            width: double.infinity,
            child: images.isEmpty
                ? const ImagePlaceholder()
                : CarouselSlider.builder(
                    // carouselController: _controller,
                    itemCount: images.length,
                    itemBuilder: (context, index, realIndex) {
                      return CachedNetworkImage(
                        height: double.infinity,
                        width: double.infinity,
                        imageUrl: images[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const ImagePlaceholder(),
                        errorWidget: (context, url, error) =>
                            const ImagePlaceholder(),
                      );
                    },
                    options: CarouselOptions(
                      height: 380,

                      autoPlay: images.length > 1,
                      enableInfiniteScroll: images.length > 1,
                      autoPlayInterval: const Duration(seconds: 2),
                      enlargeCenterPage: false,
                      pauseAutoPlayOnTouch: true,
                      viewportFraction: 1,
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 700,
                      ),
                      autoPlayCurve: Curves.easeInOut,
                      onPageChanged: images.length > 1
                          ? (index, _) {
                              _currentIndex = index;
                              setState(() {});
                            }
                          : null,
                    ),
                  ),
          ),
        ),

        // Page Indicator
        if (images.length > 1)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: CustomIndicator(
              count: images.length,
              currentPage: _currentIndex,
            ),
          ),

        // Back Button
        Positioned(
          top: 16,
          left: 16,
          child: _CircularIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            iconSize: 18,
            onTap: () => context.pop(),
          ),
        ),

        // Favorite Button
        Positioned(
          top: 16,
          right: 16,
          child: _CircularIconButton(
            icon: widget.isFavorite
                ? Icons.favorite_rounded
                : Icons.favorite_outline,
            iconColor: widget.isFavorite
                ? context.colors.error
                : context.colors.onSurface,
            onTap: widget.onFavoriteTap,
          ),
        ),
      ],
    );
  }
}

class _CircularIconButton extends StatelessWidget {
  const _CircularIconButton({
    required this.icon,
    required this.onTap,
    this.iconSize = 20,
    this.iconColor,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? AppColors.grey2.withValues(alpha: 220)
              : AppColors.white.withValues(alpha: 235),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor ?? context.colors.onSurface,
        ),
      ),
    );
  }
}
