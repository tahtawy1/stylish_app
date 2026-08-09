import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/di/service_locator.dart';
import 'package:stylish_app/features/auth/presentation/view_model/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:stylish_app/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:stylish_app/features/auth/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:stylish_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:stylish_app/features/auth/presentation/views/login_view.dart';
import 'package:stylish_app/features/auth/presentation/views/register_view.dart';
import 'package:stylish_app/features/category/presentation/view/categories_view.dart';
import 'package:stylish_app/features/category/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:stylish_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:stylish_app/features/home/presentation/views/home_view.dart';
import 'package:stylish_app/features/home/presentation/views/layout.dart';
import 'package:stylish_app/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:stylish_app/features/onboarding/presentation/view/splash_view.dart';
import 'package:stylish_app/features/onboarding/view_model/splash_cubit/splash_cubit.dart';
import 'package:stylish_app/features/product/presentation/view_model/custom_section/custom_section_cubit.dart';
import 'package:stylish_app/features/product/presentation/view_model/product_details_cubit/product_details_cubit.dart';
import 'package:stylish_app/features/product/presentation/views/custom_section_view.dart';
import 'package:stylish_app/features/product/presentation/views/product_details_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/layout',
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
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider<LoginCubit>(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => BlocProvider<RegisterCubit>(
          create: (context) => getIt<RegisterCubit>(),
          child: const RegisterView(),
        ),
      ),
      GoRoute(
        path: '/forget_password',
        builder: (context, state) => BlocProvider<ForgotPasswordCubit>(
          create: (context) => getIt<ForgotPasswordCubit>(),
          child: const ForgotPasswordView(),
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => BlocProvider<HomeCubit>(
          create: (context) => getIt<HomeCubit>()..loadHome(),
          child: const HomeView(),
        ),
      ),
      GoRoute(path: '/layout', builder: (context, state) => const Layout()),
      GoRoute(
        path: '/product_details',
        builder: (context, state) {
          final productId = state.extra as String;
          return BlocProvider(
            create: (context) => getIt<ProductDetailsCubit>(),
            child: ProductDetailsView(productId: productId),
          );
        },
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<CategoryCubit>()..loadCategories(),
            child: const CategoriesView(),
          );
        },
      ),
      GoRoute(
        path: '/custom_section',
        builder: (context, state) {
          final type = state.extra as CustomSectionType;
          return BlocProvider(
            create: (context) => getIt<CustomSectionCubit>(),
            child: CustomSectionView(sectionType: type),
          );
        },
      ),
    ],
  );
}
