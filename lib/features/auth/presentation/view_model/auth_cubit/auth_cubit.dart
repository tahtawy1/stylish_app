import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/auth/domain/entities/user_entity.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth auth;
  final AuthRepository authRepository;
  StreamSubscription<User?>? _authStateSubscription;

  AuthCubit({required this.auth, required this.authRepository})
    : super(
        AuthState(
          status: auth.currentUser != null
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
          user: auth.currentUser,
        ),
      ) {
    if (auth.currentUser != null) {
      fetchUserEntity();
    }
    _authStateSubscription = auth.userChanges().listen((user) async {
      if (!isClosed) {
        if (user != null) {
          emit(
            state.copyWith(
              status: AuthStatus.authenticated,
              user: user,
            ),
          );
          await fetchUserEntity();
        } else {
          emit(
            const AuthState(
              status: AuthStatus.unauthenticated,
              user: null,
              userEntity: null,
            ),
          );
        }
      }
    });
  }

  Future<void> fetchUserEntity() async {
    final result = await authRepository.getUserData();
    result.fold(
      (failure) => null,
      (userEntity) {
        if (!isClosed && userEntity != null) {
          emit(state.copyWith(userEntity: userEntity));
        }
      },
    );
  }

  Future<void> logOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
