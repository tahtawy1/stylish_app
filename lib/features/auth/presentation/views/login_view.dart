import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/widgets/app_button.dart';
import 'package:stylish_app/core/widgets/circular_icon_button.dart';
import 'package:stylish_app/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:stylish_app/features/auth/presentation/widgets/login/login_forgot_password_row.dart';
import 'package:stylish_app/features/auth/presentation/widgets/login/login_form.dart';
import 'package:stylish_app/features/auth/presentation/widgets/shared/auth_bottom_nav_text.dart';
import 'package:stylish_app/features/auth/presentation/widgets/shared/auth_header.dart';
import 'package:stylish_app/features/auth/presentation/widgets/shared/auth_or_divider.dart';
import 'package:stylish_app/features/auth/presentation/widgets/shared/social_auth_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _autoValidateMode = AutovalidateMode.onUnfocus;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool enableLoginButton = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is VerifyEmail) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.verifyEmailMessage)));
        } else if (state is LoginSuccess) {
          context.pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircularIconButton(
                  icon: Icons.arrow_back_ios,
                  onTap: () => context.pop(),
                ),
                const SizedBox(height: 16),
                AuthHeader(
                  title: l10n.loginTitle,
                  subtitle: l10n.loginSubtitle,
                ),
                const SizedBox(height: 32),
                LoginForm(
                  formKey: _formKey,
                  autoValidateMode: _autoValidateMode,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  emailLabel: l10n.fieldEmail,
                  passwordLabel: l10n.fieldPassword,
                  emailHint: l10n.hintEmail,
                  passwordHint: l10n.hintPassword,
                ),
                const SizedBox(height: 8),
                LoginForgotPasswordRow(
                  prefixText: l10n.loginForgotPassword,
                  actionText: l10n.loginForgotPasswordAction,
                  onTap: () {
                    context.push('/forget_password');
                  },
                ),
                const SizedBox(height: 24),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return AppButton(
                      loading: state is LoginLoading,
                      title: l10n.loginButton,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<LoginCubit>().login(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                AuthOrDivider(label: l10n.orDivider),
                const SizedBox(height: 20),
                Column(
                  children: [
                    SocialAuthButton(
                      label: l10n.loginWithGoogle,
                      iconPath: 'assets/images/google_icon.svg',
                      onPressed: () {
                        context.read<LoginCubit>().loginWithGoogle();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AuthBottomNavText(
              prefixText: l10n.loginNoAccount,
              actionText: l10n.loginJoin,
              onActionTap: () {
                context.push('/register');
              },
            ),
          ),
        ),
      ),
    );
  }
}
