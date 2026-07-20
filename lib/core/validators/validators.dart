import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

abstract final class Validators {
  static String? validateRequired(BuildContext context, String? value) {
    return _validateEmpty(context, value);
  }

  static String? validateName(BuildContext context, String? value) {
    if (_validateEmpty(context, value) != null) {
      return _validateEmpty(context, value);
    }

    if (value!.length < 2) {
      return context.l10n.nameTooShortValidation;
    }

    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    if (_validateEmpty(context, value) != null) {
      return _validateEmpty(context, value);
    }

    if (!EmailValidator.validate(value!)) {
      return context.l10n.invalidEmailValidation;
    }

    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (_validateEmpty(context, value) != null) {
      return _validateEmpty(context, value);
    }

    if (value!.length < 8) {
      return context.l10n.passwordTooShortValidation;
    }

    return null;
  }

  static String? validateConfirmPassword({
    required String? value,
    required String password,
    required BuildContext context,
  }) {
    if (_validateEmpty(context, value) != null) {
      return _validateEmpty(context, value);
    }

    if (value != password) {
      return context.l10n.passwordsDoNotMatchValidation;
    }

    return null;
  }

  static String? _validateEmpty(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.fieldRequiredValidation;
    }
    return null;
  }
}
