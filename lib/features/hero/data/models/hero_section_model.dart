import 'package:stylish_app/features/hero/domain/entities/hero_section_entity.dart';

class HeroSectionModel extends HeroSectionEntity {
  HeroSectionModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.imageUrl,
    required super.actionType,
    required super.actionValue,
    required super.isActive,
    required super.priority,
  });

  factory HeroSectionModel.fromJson(
    Map<String, dynamic> map, {
    String? docId,
  }) {
    return HeroSectionModel(
      id: (map['id'] ?? docId ?? '') as String,
      title: (map['title'] ?? '') as String,
      subtitle: map['subtitle'] as String?,
      imageUrl: (map['imageUrl'] ?? '') as String,
      actionType: HeroActionType.values.firstWhere(
        (e) => e.name == map['actionType'],
        orElse: () => HeroActionType.collection,
      ),
      actionValue: (map['actionValue'] ?? '') as String,
      isActive: (map['isActive'] ?? true) as bool,
      priority: (map['priority'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'actionType': actionType.name,
      'actionValue': actionValue,
      'isActive': isActive,
      'priority': priority,
    };
  }
}
