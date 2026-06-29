import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/di/service_locator.dart';
import 'package:stylish_app/core/error/error_handler.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/core/widgets/app_button.dart';
import 'package:stylish_app/features/onboarding/view_model/onboarding_cubit/onboarding_cubit.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnboardingCubit>(),
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingSeen || state is NavigateToAuth) {
            // Navigate to Auth screen when done
            // context.go('/auth');
            log('Navigate to Auth');
          } else if (state is OnboardingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(ErrorHandler.getMessage(context, state.failure)),
              ),
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24),
                  child: _OnboardingTitle(),
                ),
                const OnboardingImage(),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.shadow,
                          blurRadius: 0,
                          spreadRadius: 3,
                          offset: const Offset(1, 1.5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: AppButton(
                      title: context.l10n.onBoardingButtonTitle,
                      postfixIcon: Icons.arrow_forward_rounded,
                      onPressed: () {
                        context.read<OnboardingCubit>().saveOnboardingSeen();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingImage extends StatelessWidget {
  const OnboardingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -MediaQuery.of(context).size.height * 0.9,
      right: -MediaQuery.of(context).size.width * 0.3,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 25,
              offset: Offset(250, 100),
            ),
          ],
        ),
        child: Image.asset(
          'assets/images/person_onboarding.png',
          height: 820,
          width: 564,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _OnboardingTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.onBoardingTitle,

      style: context.textStyle.displayLarge?.copyWith(height: 0.8),
    );
  }
}
