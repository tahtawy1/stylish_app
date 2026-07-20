import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';

class EmailVerifiedUseCase {
  final AuthRepository repository;
  EmailVerifiedUseCase({required this.repository});

  Either<Failure, bool> call() {
    return repository.emailVerified();
  }
}
