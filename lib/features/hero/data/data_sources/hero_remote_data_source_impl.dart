import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/hero/data/data_sources/hero_remote_data_source.dart';
import 'package:stylish_app/features/hero/data/models/hero_section_model.dart';

class HeroRemoteDataSourceImpl implements HeroRemoteDataSource {
  final FirebaseFirestore firestore;

  HeroRemoteDataSourceImpl({required this.firestore});
  @override
  Future<List<HeroSectionModel>> getHeroSections() async {
    try {
      final snapshot = await firestore
          .collection('hero_sections')
          .where('isActive', isEqualTo: true)
          .orderBy('priority')
          .get();
      return snapshot.docs
          .map((doc) => HeroSectionModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
