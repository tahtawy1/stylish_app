import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/widgets/app_button.dart';
import 'package:stylish_app/features/auth/presentation/widgets/register/register_form.dart';
import 'package:stylish_app/features/auth/presentation/widgets/register/register_terms_text.dart';
import 'package:stylish_app/features/auth/presentation/widgets/shared/auth_bottom_nav_text.dart';
import 'package:stylish_app/features/auth/presentation/widgets/shared/auth_header.dart';
import 'package:stylish_app/features/auth/presentation/widgets/shared/auth_or_divider.dart';
import 'package:stylish_app/features/auth/presentation/widgets/shared/auth_social_buttons.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthHeader(
                title: l10n.registerTitle,
                subtitle: l10n.registerSubtitle,
              ),
              const SizedBox(height: 32),
              RegisterForm(
                fullNameController: _fullNameController,
                emailController: _emailController,
                passwordController: _passwordController,
                fullNameLabel: l10n.fieldFullName,
                emailLabel: l10n.fieldEmail,
                passwordLabel: l10n.fieldPassword,
                fullNameHint: l10n.hintFullName,
                emailHint: l10n.hintEmail,
                passwordHint: l10n.hintPassword,
              ),
              const SizedBox(height: 12),
              RegisterTermsText(
                prefix: l10n.registerTermsPrefix,
                termsLabel: l10n.registerTerms,
                privacyLabel: l10n.registerPrivacyPolicy,
                andLabel: l10n.registerAnd,
                cookieLabel: l10n.registerCookieUse,
                onTermsTap: () {
                  // TODO: open Terms
                },
                onPrivacyTap: () {
                  // TODO: open Privacy Policy
                },
                onCookieTap: () {
                  // TODO: open Cookie Use
                },
              ),
              const SizedBox(height: 24),
              AppButton(
                title: l10n.registerButton,
                onPressed: () {
                  // TODO: trigger register logic
                },
              ),
              const SizedBox(height: 20),
              AuthOrDivider(label: l10n.orDivider),
              const SizedBox(height: 20),
              AuthSocialButtons(
                googleLabel: l10n.registerWithGoogle,
                facebookLabel: l10n.registerWithFacebook,
                onGooglePressed: () {
                  // TODO: Google sign-up
                },
                onFacebookPressed: () {
                  // TODO: Facebook sign-up
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AuthBottomNavText(
            prefixText: l10n.registerHaveAccount,
            actionText: l10n.registerLogIn,
            onActionTap: () {
              context.pop();
            },
          ),
        ),
      ),
    );
  }
}
