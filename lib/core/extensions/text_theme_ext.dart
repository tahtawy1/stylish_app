import 'package:flutter/material.dart';

extension TextThemeExt on BuildContext {
  TextTheme get textStyle => Theme.of(this).textTheme;
}
