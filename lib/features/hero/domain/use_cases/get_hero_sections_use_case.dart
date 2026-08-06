import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/hero/domain/entities/hero_section_entity.dart';
import 'package:stylish_app/features/hero/domain/repositories/hero_repository.dart';

class GetHeroSectionsUseCase {
  final HeroRepository repository;
  GetHeroSectionsUseCase({required this.repository});
  Future<Either<Failure, List<HeroSectionEntity>>> call() async {
    return await repository.getHeroSections();
  }
}
