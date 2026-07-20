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

  @override
  String get loginTitle => 'Login to your account';

  @override
  String get loginSubtitle => 'It\'s great to see you again.';

  @override
  String get loginButton => 'Login';

  @override
  String get loginWithGoogle => 'Login with Google';

  @override
  String get loginWithFacebook => 'Login with Facebook';

  @override
  String get loginForgotPassword => 'Forgot your password?';

  @override
  String get loginForgotPasswordAction => 'Reset your password';

  @override
  String get loginNoAccount => 'Don\'t have an account?';

  @override
  String get loginJoin => 'Join';

  @override
  String get registerTitle => 'Create an account';

  @override
  String get registerSubtitle => 'Let\'s create your account.';

  @override
  String get registerButton => 'Create an Account';

  @override
  String get registerWithGoogle => 'Sign Up with Google';

  @override
  String get registerWithFacebook => 'Sign Up with Facebook';

  @override
  String get registerHaveAccount => 'Already have an account?';

  @override
  String get registerLogIn => 'Log In';

  @override
  String get registerTermsPrefix => 'By signing up you agree to our ';

  @override
  String get registerTerms => 'Terms';

  @override
  String get registerPrivacyPolicy => 'Privacy Policy';

  @override
  String get registerAnd => ' and ';

  @override
  String get registerCookieUse => 'Cookie Use';

  @override
  String get forgotPasswordTitle => 'Forgot password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email for the verification process. We will send 4 digits code to your email.';

  @override
  String get forgotPasswordButton => 'Send Code';

  @override
  String get fieldFullName => 'Full Name';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldPassword => 'Password';

  @override
  String get hintFullName => 'Enter your full name';

  @override
  String get hintEmail => 'Enter your email address';

  @override
  String get hintPassword => 'Enter your password';

  @override
  String get orDivider => 'Or';

  @override
  String get fieldRequiredValidation => 'This field is required.';

  @override
  String get nameTooShortValidation => 'Name must be at least 2 characters.';

  @override
  String get invalidEmailValidation => 'Please enter a valid email address.';

  @override
  String get passwordTooShortValidation =>
      'Password must be at least 8 characters.';

  @override
  String get passwordsDoNotMatchValidation => 'Passwords do not match.';

  @override
  String get verifyEmailMessage =>
      'Please verify your email address before logging in.';

  @override
  String get registerSuccessMessage =>
      'Account created! Please check your email to verify your account.';

  @override
  String get forgotPasswordSuccess =>
      'Password reset email sent. Please check your inbox.';
}
