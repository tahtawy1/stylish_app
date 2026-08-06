part of 'register_cubit.dart';

sealed class RegisterState {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccessAndAskToVerify extends RegisterState {
  const RegisterSuccessAndAskToVerify();
}

final class RegisterError extends RegisterState {
  final String message;
  const RegisterError({required this.message});
}

final class RegisterWithGoogleSuccess extends RegisterState {}
