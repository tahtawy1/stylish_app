import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylish_app/core/error/exceptions.dart';
import 'package:stylish_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:stylish_app/features/auth/data/models/user_model.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth auth;

  AuthDataSourceImpl({required this.auth});
  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(code: e.code, message: e.message ?? '');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException(code: e.code, message: e.message ?? '');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(code: e.code, message: e.message ?? '');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
