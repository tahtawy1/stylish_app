import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/validators/validators.dart';
import 'package:stylish_app/core/widgets/app_text_field.dart';

/// Full Name + Email + Password fields for the Register screen.
class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.autoValidateMode,
    required this.fullNameLabel,
    required this.emailLabel,
    required this.passwordLabel,
    required this.nameHint,
    required this.emailHint,
    required this.passwordHint,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AutovalidateMode autoValidateMode;
  final String fullNameLabel;
  final String emailLabel;
  final String passwordLabel;
  final String nameHint;
  final String emailHint;
  final String passwordHint;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fullNameLabel,
            style: context.textStyle.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          AppTextField(
            hint: nameHint,
            controller: fullNameController,
            keyboardType: TextInputType.name,
            validator: (value) => Validators.validateName(context, value),
            state: FieldState.initial,
            autovalidateMode: autoValidateMode,
          ),
          const SizedBox(height: 16),
          Text(
            emailLabel,
            style: context.textStyle.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          AppTextField(
            hint: emailHint,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validators.validateEmail(context, value),
            state: FieldState.initial,
            autovalidateMode: autoValidateMode,
          ),
          const SizedBox(height: 16),
          Text(
            passwordLabel,
            style: context.textStyle.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          AppTextField(
            hint: passwordHint,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) => Validators.validatePassword(context, value),
            state: FieldState.initial,
            autovalidateMode: autoValidateMode,
            passwordField: true,
          ),
        ],
      ),
    );
  }
}
