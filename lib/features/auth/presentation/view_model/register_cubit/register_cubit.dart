import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/auth/domain/usecases/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

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
      (failure) => emit(RegisterError(message: failure.message)),
      (response) => emit(RegisterSuccess()),
    );
  }
}
