import 'package:flutter/material.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/core/extensions/build_context.dart'; // افترض وجوده لجلب l10n

extension FailureExtension on Failure {
  /// تحويل הـ Failure إلى رسالة مترجمة تناسب المستخدم النهائي باستخدام Pattern Matching
  String toMessage(BuildContext context) {
    return switch (this) {
      CacheFailure() => context.l10n.cacheError,
      NetworkFailure() => context.l10n.networkError,
      AuthFailure(code: final code) => _getAuthMessage(context, code),
      ServerFailure() => context.l10n.serverError,
      _ => context.l10n.unexpectedError,
    };
  }

  /// Helper method لترجمة أخطاء Firebase Auth بناءً على كود الخطأ
  String _getAuthMessage(BuildContext context, String code) {
    return switch (code) {
      'user-not-found' => context.l10n.userNotFound,
      'wrong-password' => context.l10n.wrongPassword,
      'email-already-in-use' => context.l10n.emailAlreadyInUse,
      'invalid-email' => context.l10n.invalidEmail,
      'network-request-failed' => context.l10n.networkError,
      _ => context.l10n.authError,
    };
  }
}
