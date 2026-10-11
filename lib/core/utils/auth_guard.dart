import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/auth/widgets/login_required_bottom_sheet.dart';
import 'package:stylish_app/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';

export 'package:stylish_app/core/auth/widgets/login_required_bottom_sheet.dart'
    show LoginRequiredAction, showLoginRequiredBottomSheet;

class AuthGuard {
  AuthGuard._();
  static bool requireAuth(
    BuildContext context, {
    LoginRequiredAction action = LoginRequiredAction.favorites,
    String? customMessage,
  }) {
    final isAuthenticated =
        context.read<AuthCubit>().state.status == AuthStatus.authenticated;

    if (isAuthenticated) return true;

    showLoginRequiredBottomSheet(
      context,
      action: action,
      customMessage: customMessage,
    );
    return false;
  }
}
