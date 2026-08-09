import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/validators/validators.dart';
import 'package:stylish_app/core/widgets/app_text_field.dart';

/// Single Email field shown on the Forgot Password screen.
class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
    required this.emailController,
    required this.emailLabel,
    required this.emailHint,
    required this.formKey,
    required this.autoValidateMode,
  });

  final TextEditingController emailController;
  final String emailLabel;
  final String emailHint;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
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
            validator: (value) => Validators.validateRequired(context, value),
            state: FieldState.initial,
            autovalidateMode: autoValidateMode,
          ),
        ],
      ),
    );
  }
}
