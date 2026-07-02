import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;
  ForgotPasswordUseCase({required this.repository});
  Future<Either<Failure, void>> call({required String email}) async {
    return await repository.forgotPassword(email: email);
  }
}
