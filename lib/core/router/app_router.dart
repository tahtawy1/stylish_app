import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/di/service_locator.dart';
import 'package:stylish_app/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:stylish_app/features/onboarding/presentation/view/splash_view.dart';
import 'package:stylish_app/features/onboarding/view_model/splash_cubit/splash_cubit.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider<SplashCubit>(
          create: (context) => getIt<SplashCubit>(),
          child: const SplashView(),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingView(),
      ),
    ],
  );
}
