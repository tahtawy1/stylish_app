import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/auth/domain/usecases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await loginUseCase.call(email: email, password: password);
    result.fold(
      (failure) => emit(LoginError(message: failure.message)),
      (response) => emit(LoginSuccess()),
    );
  }
}
