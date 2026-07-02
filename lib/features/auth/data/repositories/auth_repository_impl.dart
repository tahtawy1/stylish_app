import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/exceptions.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/data/data_sources/auth_data_source.dart';
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
}
