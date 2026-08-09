import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/hero/data/data_sources/hero_remote_data_source.dart';
import 'package:stylish_app/features/hero/domain/entities/hero_section_entity.dart';
import 'package:stylish_app/features/hero/domain/repositories/hero_repository.dart';

class HeroRepositoryImpl implements HeroRepository {
  final HeroRemoteDataSource remoteDataSource;

  HeroRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<HeroSectionEntity>>> getHeroSections() async {
    try {
      final result = await remoteDataSource.getHeroSections();
      return right(result);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
