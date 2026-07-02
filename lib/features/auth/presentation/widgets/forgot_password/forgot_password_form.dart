import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/widgets/app_text_field.dart';

/// Single Email field shown on the Forgot Password screen.
class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
    required this.emailController,
    required this.emailLabel,
    required this.emailHint,
  });

  final TextEditingController emailController;
  final String emailLabel;
  final String emailHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          emailLabel,
          style: context.textStyle.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        AppTextField(
          hint: emailHint,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (_) => null,
          state: FieldState.initial,
          autovalidateMode: AutovalidateMode.disabled,
        ),
      ],
    );
  }
}
