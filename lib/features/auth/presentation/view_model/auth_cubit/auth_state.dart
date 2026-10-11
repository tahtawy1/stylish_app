part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final User? user;
  final UserEntity? userEntity;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.user,
    this.userEntity,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    UserEntity? userEntity,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      userEntity: userEntity ?? this.userEntity,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
