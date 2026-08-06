import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stylish_app/core/app/app.dart';
import 'package:stylish_app/core/app/app_initializer.dart';
import 'package:stylish_app/core/di/service_locator.dart';
import 'package:stylish_app/features/hero/domain/entities/hero_section_entity.dart';

void main() async {
  await AppInitializer().initApp();
  await setupLocators();
  await getIt<GoogleSignIn>().initialize(
    serverClientId:
        '685514868509-5rdu17p5jgmqpdeamsa10e5dqqrb7n1m.apps.googleusercontent.com',
  );

  runApp(const App());
}
