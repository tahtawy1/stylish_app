import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylish_app/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<void> register({
    required String name,
    required String email,
    required String password,
  });
  Future<void> saveUser(UserModel user);
  Future<void> login({required String email, required String password});
  Future<void> forgotPassword({required String email});
  Future<void> sendEmailVerification();
  bool emailVerified();
  Future<void> signWithGoogle();
  Future<String> getUserName();
  Future<UserModel?> getUserData();

  User? get currentUser;
  bool get isAuthenticated;
  Future<void> logOut();
}
