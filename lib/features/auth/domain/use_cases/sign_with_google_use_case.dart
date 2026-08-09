import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';

class SignWithGoogleUseCase {
  final AuthRepository authRepository;

  SignWithGoogleUseCase({required this.authRepository});
  Future<Either<Failure, void>> call() async {
    return await authRepository.signWithGoogle();
  }
}
