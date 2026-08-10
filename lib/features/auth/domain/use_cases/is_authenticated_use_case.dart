import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';

class IsAuthenticatedUseCase {
  final AuthRepository authRepository;
  IsAuthenticatedUseCase({required this.authRepository});
  Future<Either<Failure, bool>> call() async {
    return authRepository.isAuthenticated;
  }
}
