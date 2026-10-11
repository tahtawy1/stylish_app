import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepository;
  GetCurrentUserUseCase({required this.authRepository});
  Either<Failure, User?> call() {
    return authRepository.currentUser;
  }
}
