import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth auth;
  StreamSubscription<User?>? _authStateSubscription;

  AuthCubit({required this.auth})
    : super(
        AuthState(
          status: auth.currentUser != null
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
          user: auth.currentUser,
        ),
      ) {
    _authStateSubscription = auth.authStateChanges().listen((user) {
      if (!isClosed) {
        emit(
          AuthState(
            status: user != null
                ? AuthStatus.authenticated
                : AuthStatus.unauthenticated,
            user: user,
          ),
        );
      }
    });
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
