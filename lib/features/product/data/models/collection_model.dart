import 'package:stylish_app/features/product/domain/entities/collection_entity.dart';

class CollectionModel extends CollectionEntity {
  CollectionModel({
    required super.id,
    required super.name,
    required super.image,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
