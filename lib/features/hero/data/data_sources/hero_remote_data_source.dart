import 'package:stylish_app/features/hero/data/models/hero_section_model.dart';

abstract class HeroRemoteDataSource {
  Future<List<HeroSectionModel>> getHeroSections();
}
