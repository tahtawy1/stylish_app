import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> saveUser(UserModel user);
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> forgotPassword({required String email});
  Future<Either<Failure, void>> sendEmailVerification();
  Either<Failure, bool> emailVerified();
  Future<Either<Failure, void>> signWithGoogle();
  Future<Either<Failure, void>> signWithFacebook();
}
