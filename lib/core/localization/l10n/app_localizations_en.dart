// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Stylish';

  @override
  String get onBoardingTitle => 'Define yourself in your unique way.';

  @override
  String get onBoardingButtonTitle => 'Get Started';

  @override
  String get unknownError => 'An unknown error occurred, please try again.';

  @override
  String get unexpectedError => 'An unexpected error occurred.';

  @override
  String get cacheError => 'Failed to load cached data.';

  @override
  String get networkError => 'Please check your internet connection.';

  @override
  String get serverError => 'Server error, please try again later.';

  @override
  String get authError => 'Authentication failed, please try again.';

  @override
  String get userNotFound => 'No user found for that email.';

  @override
  String get wrongPassword => 'Wrong password provided for that user.';

  @override
  String get emailAlreadyInUse => 'The account already exists for that email.';

  @override
  String get invalidEmail => 'The email address is badly formatted.';
}
