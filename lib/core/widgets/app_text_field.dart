import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    required this.state,
    this.passwordField = false,
    required this.autovalidateMode,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final AutovalidateMode autovalidateMode;
  final String hint;

  final FieldState state;
  final bool passwordField;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: widget.keyboardType,
      obscureText: widget.passwordField ? !passwordVisible : false,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: context.textStyle.bodyLarge?.copyWith(
          color: AppColors.grey7,
        ),

        suffixIcon: widget.passwordField == true
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                child: Icon(
                  passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : widget.state == FieldState.error
            ? Icon(Icons.error_outline, color: context.colors.error)
            : widget.state == FieldState.success
            ? const Icon(Icons.check_circle_outline, color: AppColors.green)
            : null,

        enabledBorder: _border(
          context,
          widget.state == FieldState.initial
              ? context.colors.outline
              : widget.state == FieldState.success
              ? Colors.green
              : context.colors.error,
        ),
        focusedBorder: _border(
          context,
          widget.state == FieldState.initial
              ? context.colors.primary
              : widget.state == FieldState.success
              ? Colors.green
              : context.colors.error,
        ),
        errorBorder: _border(context, context.colors.error),
        focusedErrorBorder: _border(context, context.colors.error),
      ),
    );
  }

  OutlineInputBorder _border(BuildContext context, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }
}

enum FieldState { initial, error, success }
