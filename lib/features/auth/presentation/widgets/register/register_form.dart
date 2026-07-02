import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/widgets/app_text_field.dart';

/// Full Name + Email + Password fields for the Register screen.
class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.fullNameLabel,
    required this.emailLabel,
    required this.passwordLabel,
    required this.fullNameHint,
    required this.emailHint,
    required this.passwordHint,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String fullNameLabel;
  final String emailLabel;
  final String passwordLabel;
  final String fullNameHint;
  final String emailHint;
  final String passwordHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fullNameLabel, style: context.textStyle.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        AppTextField(
          hint: fullNameHint,
          controller: fullNameController,
          keyboardType: TextInputType.name,
          validator: (_) => null,
          state: FieldState.initial,
          autovalidateMode: AutovalidateMode.disabled,
        ),
        const SizedBox(height: 16),
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
