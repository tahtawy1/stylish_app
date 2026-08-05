import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

String getGreeting(BuildContext context) {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return context.l10n.morningGreeting;
  } else if (hour >= 12 && hour < 17) {
    return context.l10n.afternoonGreeting;
  } else {
    return context.l10n.eveningGreeting;
  }
}
