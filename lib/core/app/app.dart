import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stylish_app/core/di/service_locator.dart';
import 'package:stylish_app/core/localization/l10n/app_localizations.dart';
import 'package:stylish_app/core/router/app_router.dart';
import 'package:stylish_app/core/theme/app_theme.dart';
import 'package:stylish_app/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:stylish_app/features/favorite/presentation/view_model/favorite_cubit/favorite_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
        BlocProvider<FavoriteCubit>(
          create: (context) =>
              getIt<FavoriteCubit>()..getUserFavoriteProductsIds(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
      ),
    );
  }
}
