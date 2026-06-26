import 'package:email_validator/email_validator.dart';

abstract final class Validators {
  static String? validateName(String? value) {
    if (_validateEmpty(value) != null) {
      return null; //todo: add l10n
    }

    if (value!.length < 2) {
      return null; //todo: add l10n
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (_validateEmpty(value) != null) {
      return null; //todo: add l10n
    }

    if (!EmailValidator.validate(value!)) {
      return null; //todo: add l10n
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (_validateEmpty(value) != null) {
      return null; //todo: add l10n
    }

    if (value!.length < 8) {
      return null; //todo: add l10n
    }

    return null;
  }

  static String? validateConfirmPassword({
    required String? value,
    required String password,
  }) {
    if (_validateEmpty(value) != null) {
      return null; //todo: add l10n
    }

    if (value != password) {
      return null; //todo: add l10n
    }

    return null;
  }

  static String? _validateEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; //todo: add l10n
    }
    return null;
  }
}
