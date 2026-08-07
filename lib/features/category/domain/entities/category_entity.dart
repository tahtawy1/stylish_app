class CategoryEntity {
  final String id;
  final String name;
  final String imageUrl;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory CategoryEntity.fake() =>
      CategoryEntity(id: '1', name: 'Category', imageUrl: '');
}
