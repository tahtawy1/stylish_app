import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/auth/domain/usecases/forgot_password_use_case.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.forgotPasswordUseCase)
    : super(ForgotPasswordInitial());

  final ForgotPasswordUseCase forgotPasswordUseCase;
  Future<void> forgotPassword({required String email}) async {
    emit(ForgotPasswordLoading());
    final result = await forgotPasswordUseCase(email: email);
    result.fold(
      (failure) => emit(ForgotPasswordError(message: failure.message)),
      (response) => emit(ForgotPasswordSuccess()),
    );
  }
}
