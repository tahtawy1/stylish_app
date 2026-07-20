import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stylish_app/core/error/exceptions.dart';
import 'package:stylish_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:stylish_app/features/auth/data/models/user_model.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  AuthDataSourceImpl({required this.auth, required this.googleSignIn});
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

  @override
  Future<void> sendEmailVerification() async {
    try {
      await auth.currentUser?.sendEmailVerification();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  bool emailVerified() {
    try {
      return auth.currentUser?.emailVerified ?? true;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> signWithFacebook() {
    // TODO: implement signWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<void> signWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
