import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stylish_app/core/app/app.dart';
import 'package:stylish_app/core/app/app_initializer.dart';

void main() async {
  await AppInitializer().initApp();
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const App()),
  );
}
