import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, bool>> isOnboardingSeen();
  Future<Either<Failure, void>> saveOnboardingSeen();
}
