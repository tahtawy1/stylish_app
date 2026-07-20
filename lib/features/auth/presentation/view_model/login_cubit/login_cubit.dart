import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/auth/domain/use_cases/email_verified_use_case.dart';
import 'package:stylish_app/features/auth/domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final EmailVerifiedUseCase emailVerifiedUseCase;
  LoginCubit({required this.loginUseCase, required this.emailVerifiedUseCase})
    : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await loginUseCase(email: email, password: password);
    result.fold((failure) => emit(LoginError(message: failure.message)), (
      response,
    ) {
      final result = emailVerifiedUseCase();
      result.fold((failure) {}, (result) {
        if (result) {
          emit(LoginSuccess());
        } else {
          emit(const VerifyEmail());
        }
      });
    });
  }
}
