import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:stylish_app/features/auth/domain/use_cases/send_email_verification_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  final SendEmailVerificationUseCase sendEmailVerificationUseCase;
  RegisterCubit({
    required this.registerUseCase,
    required this.sendEmailVerificationUseCase,
  }) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    final result = await registerUseCase(
      name: name,
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        log(failure.message);
        emit(RegisterError(message: failure.message));
      },
      (response) {
        sendEmailVerificationUseCase();
        emit(const RegisterSuccessAndAskToVerify());
      },
    );
  }
}
