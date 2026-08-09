import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/widgets/app_button.dart';
import 'package:stylish_app/features/auth/presentation/view_model/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:stylish_app/features/auth/presentation/widgets/forgot_password/forgot_password_form.dart';
import 'package:stylish_app/features/auth/presentation/widgets/shared/auth_header.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _autoValidateMode = AutovalidateMode.onUnfocus;
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.forgotPasswordSuccess)));
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.colors.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: const BackButton(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: l10n.forgotPasswordTitle,
                  subtitle: l10n.forgotPasswordSubtitle,
                ),
                const SizedBox(height: 32),
                ForgotPasswordForm(
                  formKey: _formKey,
                  autoValidateMode: _autoValidateMode,
                  emailController: _emailController,
                  emailLabel: l10n.fieldEmail,
                  emailHint: l10n.hintEmail,
                ),
                const SizedBox(height: 32),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    return AppButton(
                      loading: state is ForgotPasswordLoading,
                      title: l10n.forgotPasswordButton,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ForgotPasswordCubit>().forgotPassword(
                            email: _emailController.text.trim(),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
