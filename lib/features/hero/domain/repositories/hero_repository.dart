import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/hero/domain/entities/hero_section_entity.dart';

abstract class HeroRepository {
  Future<Either<Failure, List<HeroSectionEntity>>> getHeroSections();
}
