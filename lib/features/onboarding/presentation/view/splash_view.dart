import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/features/onboarding/view_model/splash_cubit/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnim;
  late Animation<Offset> _posAnim;
  bool _showText = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _sizeAnim = Tween<double>(
      begin: 140,
      end: 65,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _posAnim = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.1, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      _controller.forward().whenComplete(() {
        if (mounted) setState(() => _showText = true);
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (!mounted) return;
          context.read<SplashCubit>().checkAppRouting();
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToOnboarding) {
          context.go('/onboarding');
        } else if (state is SplashNavigateToAuth) {
          context.go('/login');
          log("Navigate to Auth View");
        } else if (state is SplashNavigateToHome) {
          // context.go('/home');
          log("Navigate to Home View");
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.surfaceContainer,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Align(alignment: Alignment.topCenter, child: _WaveLines()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SlideTransition(
                      position: _posAnim,
                      child: AnimatedBuilder(
                        animation: _sizeAnim,
                        builder: (context, child) =>
                            _LogoWidget(sizeAnim: _sizeAnim),
                      ),
                    ),
                    const SizedBox(width: 12),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _showText
                          ? _AnimatedAppNameText()
                          : const SizedBox(key: ValueKey('empty')),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedAppNameText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      key: const ValueKey('text'),
      isRepeatingAnimation: false,
      animatedTexts: [
        TyperAnimatedText(
          context.l10n.appName,
          speed: const Duration(milliseconds: 80),
          textStyle: context.textStyle.displayMedium?.copyWith(
            color: context.colors.onPrimary,
            letterSpacing: 1.8,
          ),
        ),
      ],
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget({required Animation<double> sizeAnim})
    : _sizeAnim = sizeAnim;

  final Animation<double> _sizeAnim;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/app_logo.svg',
      width: _sizeAnim.value,
      height: _sizeAnim.value,
      colorFilter: ColorFilter.mode(context.colors.onPrimary, BlendMode.srcIn),
    );
  }
}

class _WaveLines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/wave_lines.svg',
      width: MediaQuery.of(context).size.width,
      colorFilter: const ColorFilter.mode(AppColors.grey2, BlendMode.srcIn),
    );
  }
}
