import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository authRepository;
  LogOutUseCase({required this.authRepository});
  Future<Either<Failure, void>> call() async {
    return await authRepository.logOut();
  }
}
