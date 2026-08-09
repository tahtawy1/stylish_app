import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:stylish_app/features/auth/data/data_sources/auth_data_source_impl.dart';
import 'package:stylish_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:stylish_app/features/auth/domain/use_cases/email_verified_use_case.dart';
import 'package:stylish_app/features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:stylish_app/features/auth/domain/use_cases/get_user_name_use_cases.dart';
import 'package:stylish_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:stylish_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:stylish_app/features/auth/domain/use_cases/send_email_verification_use_case.dart';
import 'package:stylish_app/features/auth/domain/use_cases/sign_with_google_use_case.dart';
import 'package:stylish_app/features/auth/presentation/view_model/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:stylish_app/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:stylish_app/features/auth/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:stylish_app/features/category/data/data_sources/category_remote_data_source.dart';
import 'package:stylish_app/features/category/data/data_sources/category_remote_data_source_impl.dart';
import 'package:stylish_app/features/category/data/repositories/category_repository_impl.dart';
import 'package:stylish_app/features/category/domain/repositories/category_repository.dart';
import 'package:stylish_app/features/category/domain/use_cases/get_categories_use_case.dart';
import 'package:stylish_app/features/category/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:stylish_app/features/hero/data/data_sources/hero_remote_data_source.dart';
import 'package:stylish_app/features/hero/data/data_sources/hero_remote_data_source_impl.dart';
import 'package:stylish_app/features/hero/data/repositories/hero_repository_impl.dart';
import 'package:stylish_app/features/hero/domain/repositories/hero_repository.dart';
import 'package:stylish_app/features/hero/domain/use_cases/get_hero_sections_use_case.dart';
import 'package:stylish_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';

import 'package:stylish_app/features/onboarding/data/data_sources/onboarding_local_data_source.dart';
import 'package:stylish_app/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:stylish_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:stylish_app/features/onboarding/view_model/onboarding_cubit/onboarding_cubit.dart';

import 'package:stylish_app/features/onboarding/view_model/splash_cubit/splash_cubit.dart';
import 'package:stylish_app/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:stylish_app/features/product/data/data_sources/product_remote_data_source_impl.dart';
import 'package:stylish_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:stylish_app/features/product/domain/repositories/product_repository.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_best_sellers_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_new_arrivals_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_on_sale_products_use_case.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_product_by_id.dart';
import 'package:stylish_app/features/product/presentation/view_model/product_details_cubit/product_details_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupLocators() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);
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
  if (!getIt.isRegistered<FirebaseFirestore>()) {
    getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  }
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(
      auth: getIt<FirebaseAuth>(),
      googleSignIn: getIt<GoogleSignIn>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
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
  getIt.registerLazySingleton<SignWithGoogleUseCase>(
    () => SignWithGoogleUseCase(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GetUserNameUseCases>(
    () => GetUserNameUseCases(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(
      loginUseCase: getIt<LoginUseCase>(),
      emailVerifiedUseCase: getIt<EmailVerifiedUseCase>(),
      signWithGoogleUseCase: getIt<SignWithGoogleUseCase>(),
    ),
  );
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(
      registerUseCase: getIt<RegisterUseCase>(),
      sendEmailVerificationUseCase: getIt<SendEmailVerificationUseCase>(),
      signWithGoogleUseCase: getIt<SignWithGoogleUseCase>(),
    ),
  );
  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(
      forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
    ),
  );

  // Home
  getIt.registerLazySingleton<HeroRemoteDataSource>(
    () => HeroRemoteDataSourceImpl(firestore: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<HeroRepository>(
    () => HeroRepositoryImpl(remoteDataSource: getIt<HeroRemoteDataSource>()),
  );
  getIt.registerLazySingleton<GetHeroSectionsUseCase>(
    () => GetHeroSectionsUseCase(repository: getIt<HeroRepository>()),
  );

  // Product
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(firestore: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      productDataSource: getIt<ProductRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetNewArrivalsProductsUseCase>(
    () => GetNewArrivalsProductsUseCase(
      productRepository: getIt<ProductRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetBestSellersProductsUseCase>(
    () => GetBestSellersProductsUseCase(
      productRepository: getIt<ProductRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetOnSaleProductsUseCase>(
    () =>
        GetOnSaleProductsUseCase(productRepository: getIt<ProductRepository>()),
  );

  getIt.registerLazySingleton<GetProductByIdUseCase>(
    () => GetProductByIdUseCase(productRepository: getIt<ProductRepository>()),
  );

  // Category
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(firestore: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: getIt<CategoryRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(repository: getIt<CategoryRepository>()),
  );

  getIt.registerFactory<CategoryCubit>(
    () => CategoryCubit(getCategoriesUseCase: getIt<GetCategoriesUseCase>()),
  );

  // Home
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getUserNameUseCases: getIt<GetUserNameUseCases>(),
      getHeroSectionsUseCase: getIt<GetHeroSectionsUseCase>(),
      getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
      getNewArrivalsProductsUseCase: getIt<GetNewArrivalsProductsUseCase>(),
      getBestSellersProductsUseCase: getIt<GetBestSellersProductsUseCase>(),
      getOnSaleProductsUseCase: getIt<GetOnSaleProductsUseCase>(),
    ),
  );

  // Product Details
  getIt.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(
      getProductByIdUseCase: getIt<GetProductByIdUseCase>(),
    ),
  );
}
