import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';

class SendEmailVerificationUseCase {
  final AuthRepository repository;
  SendEmailVerificationUseCase({required this.repository});

  Future<Either<Failure, void>> call() {
    return repository.sendEmailVerification();
  }
}
