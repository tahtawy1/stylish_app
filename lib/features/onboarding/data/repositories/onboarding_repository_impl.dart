import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/exceptions.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/onboarding/data/data_sources/onboarding_local_data_source.dart';
import 'package:stylish_app/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;
  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> isOnboardingSeen() async {
    try {
      return Right(localDataSource.isOnboardingSeen());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveOnboardingSeen() async {
    try {
      await localDataSource.saveOnboardingSeen();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
