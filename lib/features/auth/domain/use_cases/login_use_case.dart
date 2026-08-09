import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase({required this.repository});
  Future<Either<Failure, void>> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
