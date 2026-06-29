import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import 'package:stylish_app/features/onboarding/data/data_sources/onboarding_local_data_source.dart';
import 'package:stylish_app/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:stylish_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:stylish_app/features/onboarding/view_model/onboarding_cubit/onboarding_cubit.dart';

import 'package:stylish_app/features/onboarding/view_model/splash_cubit/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupLocators() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  // Onboarding
  getIt.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSource(prefs: getIt()));
  getIt.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(localDataSource: getIt()));
  getIt.registerFactory<OnboardingCubit>(
      () => OnboardingCubit(repository: getIt()));

  // Splash
  getIt.registerFactory<SplashCubit>(
      () => SplashCubit(onboardingRepository: getIt()));
}
