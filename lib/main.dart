import 'package:flutter/material.dart';
import 'package:stylish_app/core/app/app.dart';
import 'package:stylish_app/core/app/app_initializer.dart';
import 'package:stylish_app/core/di/service_locator.dart';

void main() async {
  await AppInitializer().initApp();
  await setupLocators();
  runApp(const App());
}
