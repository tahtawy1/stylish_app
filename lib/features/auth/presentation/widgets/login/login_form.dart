import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/widgets/app_text_field.dart';

/// Email + Password fields for the Login screen, isolated in their own file.
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailHint,
    required this.passwordHint,
    required this.emailLabel,
    required this.passwordLabel,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String emailHint;
  final String passwordHint;
  final String emailLabel;
  final String passwordLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emailLabel, style: context.textStyle.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        AppTextField(
          hint: emailHint,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (_) => null,
          state: FieldState.initial,
          autovalidateMode: AutovalidateMode.disabled,
        ),
        const SizedBox(height: 16),
        Text(passwordLabel, style: context.textStyle.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        AppTextField(
          hint: passwordHint,
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          validator: (_) => null,
          state: FieldState.initial,
          autovalidateMode: AutovalidateMode.disabled,
          passwordField: true,
        ),
      ],
    );
  }
}
