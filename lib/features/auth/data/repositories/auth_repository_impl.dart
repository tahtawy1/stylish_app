import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylish_app/core/error/exceptions.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:stylish_app/features/auth/data/models/user_model.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});
  @override
  Future<Either<Failure, void>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await authDataSource.register(
        name: name,
        email: email,
        password: password,
      );
      return right(null);
    } on AuthException catch (e) {
      return left(AuthFailure(code: e.code, message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUser(UserModel user) async {
    try {
      await authDataSource.saveUser(user);
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await authDataSource.login(email: email, password: password);
      return right(null);
    } on AuthException catch (e) {
      return left(AuthFailure(code: e.code, message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    try {
      await authDataSource.forgotPassword(email: email);
      return right(null);
    } on AuthException catch (e) {
      return left(AuthFailure(code: e.code, message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Either<Failure, bool> emailVerified() {
    try {
      final result = authDataSource.emailVerified();
      return right(result);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      await authDataSource.sendEmailVerification();
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signWithFacebook() async {
    try {
      await authDataSource.signWithFacebook();
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signWithGoogle() async {
    try {
      await authDataSource.signWithGoogle();
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getUserName() async {
    try {
      final result = await authDataSource.getUserName();
      return right(result);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Either<Failure, bool> get isAuthenticated =>
      right(authDataSource.isAuthenticated);

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await authDataSource.logOut();
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Either<Failure, User?> get currentUser => right(authDataSource.currentUser);
}
