import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/features/hero/domain/entities/hero_section_entity.dart';
import 'package:stylish_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:stylish_app/features/home/presentation/widgets/hero_indicator.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is HomeError) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.message)),
          );
        } else if (state is HomeLoaded) {
          if (state.heroSections.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: state.heroSections.length,
                    itemBuilder: (context, index, realIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: _HeroCard(hero: state.heroSections[index]),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: state.heroSections.length > 1,
                      autoPlayInterval: const Duration(seconds: 5),
                      enlargeCenterPage: false,
                      enableInfiniteScroll: state.heroSections.length > 1,
                      pauseAutoPlayOnTouch: true,
                      viewportFraction: 1,
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 700,
                      ),
                      autoPlayCurve: Curves.easeInOut,
                      onPageChanged: (index, _) {
                        currentPage = index;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              HeroIndicator(
                heroesCount: state.heroSections.length,
                currentPage: currentPage,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.hero});
  final HeroSectionEntity hero;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          hero.imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.grey9,
              child: const Center(
                child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _HeroInfo(title: hero.title, subtitle: hero.subtitle),
        ),
      ],
    );
  }
}

class _HeroInfo extends StatelessWidget {
  const _HeroInfo({required this.title, required this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, AppColors.grey1],
        ),
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
