import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: context.textStyle.headlineLarge);
  }
}
