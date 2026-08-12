import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/network/image_placeholder.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/features/hero/domain/entities/hero_section_entity.dart';
import 'package:stylish_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:stylish_app/features/home/presentation/widgets/custom_indicator.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int currentPage = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final isLoading = state.status == HomeStatus.loading;
        final List<HeroSectionEntity> heroes = isLoading
            ? List.generate(3, (_) => HeroSectionEntity.fake())
            : state.heroes;
        if (!isLoading && currentPage >= heroes.length) {
          currentPage = 0;
          _controller.jumpToPage(0);
        }
        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  CarouselSlider.builder(
                    carouselController: _controller,
                    itemCount: heroes.length,
                    itemBuilder: (context, index, realIndex) {
                      return _HeroCard(hero: heroes[index]);
                    },
                    options: CarouselOptions(
                      height: 230,
                      autoPlay: !isLoading && heroes.length > 1,
                      enableInfiniteScroll: !isLoading && heroes.length > 1,
                      autoPlayInterval: const Duration(seconds: 5),
                      enlargeCenterPage: false,
                      pauseAutoPlayOnTouch: true,
                      viewportFraction: 1,
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 700,
                      ),
                      autoPlayCurve: Curves.easeInOut,
                      onPageChanged: !isLoading
                          ? (index, _) {
                              currentPage = index;
                              setState(() {});
                            }
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (!isLoading)
                CustomIndicator(count: heroes.length, currentPage: currentPage),
            ],
          ),
        );
      },
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.hero});
  final HeroSectionEntity hero;

  @override
  Widget build(BuildContext context) {
    return hero.imageUrl.isEmpty
        ? HeroBone(hero: hero)
        : CachedNetworkImage(
            imageUrl: hero.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            imageBuilder: (context, imageProvider) {
              return Stack(
                children: [
                  Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _HeroInfo(
                      title: hero.title,
                      subtitle: hero.subtitle,
                    ),
                  ),
                ],
              );
            },
            placeholder: (context, url) {
              return const ImagePlaceholder();
            },
            errorWidget: (context, error, stackTrace) {
              return const ImagePlaceholder();
            },
          );
  }
}

class HeroBone extends StatelessWidget {
  const HeroBone({super.key, required this.hero});

  final HeroSectionEntity hero;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey10.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _HeroInfo(
              title: hero.title,
              subtitle: hero.subtitle,
              wantGradient: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroInfo extends StatelessWidget {
  const _HeroInfo({
    required this.title,
    required this.subtitle,
    this.wantGradient = true,
  });

  final String title;
  final String? subtitle;
  final bool wantGradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: wantGradient
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColors.grey1],
              )
            : null,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: context.textStyle.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.white,
              letterSpacing: 1.25,
            ),
          ),
          const SizedBox(height: 4),
          subtitle != null
              ? Text(
                  subtitle!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: context.textStyle.bodyMedium?.copyWith(
                    color: AppColors.white,
                    letterSpacing: 0.75,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
