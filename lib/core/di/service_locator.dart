import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:stylish_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:stylish_app/features/auth/data/data_sources/auth_data_source_impl.dart';
import 'package:stylish_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:stylish_app/features/auth/domain/use_cases/email_verified_use_case.dart';
import 'package:stylish_app/features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:stylish_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:stylish_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:stylish_app/features/auth/domain/use_cases/send_email_verification_use_case.dart';
import 'package:stylish_app/features/auth/presentation/view_model/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:stylish_app/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:stylish_app/features/auth/presentation/view_model/register_cubit/register_cubit.dart';

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
    () => OnboardingLocalDataSource(prefs: getIt()),
  );
  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: getIt()),
  );
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(repository: getIt()),
  );

  // Splash
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(onboardingRepository: getIt()),
  );

  // Auth
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(auth: getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: getIt<AuthDataSource>()),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<EmailVerifiedUseCase>(
    () => EmailVerifiedUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<SendEmailVerificationUseCase>(
    () => SendEmailVerificationUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(
      loginUseCase: getIt<LoginUseCase>(),
      emailVerifiedUseCase: getIt<EmailVerifiedUseCase>(),
    ),
  );
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(
      registerUseCase: getIt<RegisterUseCase>(),
      sendEmailVerificationUseCase: getIt<SendEmailVerificationUseCase>(),
    ),
  );
  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(
      forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
    ),
  );
}
