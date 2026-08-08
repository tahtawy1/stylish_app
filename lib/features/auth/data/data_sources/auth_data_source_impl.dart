import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stylish_app/core/error/exceptions.dart';
import 'package:stylish_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:stylish_app/features/auth/data/models/user_model.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firestore;

  AuthDataSourceImpl({
    required this.auth,
    required this.googleSignIn,
    FirebaseFirestore? firestore,
  }) : firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        final userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: email,
        );
        await saveUser(userModel);
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(code: e.code, message: e.message ?? '');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.id).set({
        'uid': user.id,
        'name': user.name,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
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
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        final firebaseUser = userCredential.user!;

        final userModel = UserModel(
          id: firebaseUser.uid,
          name: googleUser.displayName ?? '',
          email: googleUser.email,
        );

        await saveUser(userModel);
      }
    } catch (e) {
      log(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> getUserName() async {
    try {
      final userModel = await firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .get();
      return userModel.data()?['name'] ?? '';
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
