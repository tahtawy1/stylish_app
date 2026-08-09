import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/auth/domain/repositories/auth_repository.dart';

class GetUserNameUseCases {
  final AuthRepository authRepository;
  GetUserNameUseCases({required this.authRepository});
  Future<Either<Failure, String>> call() async {
    return await authRepository.getUserName();
  }
}
