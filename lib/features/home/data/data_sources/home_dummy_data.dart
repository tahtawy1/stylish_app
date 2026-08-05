import 'package:flutter/material.dart';
import 'package:stylish_app/features/home/domain/entities/product_entity.dart';

class CategoryEntity {
  final String id;
  final String label;
  final IconData icon;

  const CategoryEntity({
    required this.id,
    required this.label,
    required this.icon,
  });
}

class HomeDummyData {
  static const List<CategoryEntity> categories = [
    CategoryEntity(id: '1', label: 'All Items', icon: Icons.grid_view_rounded),
    CategoryEntity(id: '2', label: 'Dress', icon: Icons.checkroom_rounded),
    CategoryEntity(id: '3', label: 'T-Shirt', icon: Icons.dry_cleaning_rounded),
    CategoryEntity(
      id: '4',
      label: 'Pants',
      icon: Icons.accessibility_new_rounded,
    ),
  ];

  static const List<ProductEntity> products = [
    ProductEntity(
      id: '1',
      title: 'Modern Light Clothes',
      category: 'T-Shirt',
      price: 212.99,
      rating: 5.0,
      image: 'assets/images/product_1.png',
      isFavorite: false,
    ),
    ProductEntity(
      id: '2',
      title: 'Light Dress Bless',
      category: 'Dress modern',
      price: 162.99,
      rating: 5.0,
      image: 'assets/images/Product 2.png',
      isFavorite: true,
    ),
    ProductEntity(
      id: '3',
      title: 'Cool Urban Jacket',
      category: 'Jacket',
      price: 185.00,
      rating: 4.9,
      image: 'assets/images/product_3.png',
      isFavorite: false,
    ),
    ProductEntity(
      id: '4',
      title: 'Yellow Silk Top',
      category: 'Top modern',
      price: 129.50,
      rating: 4.8,
      image: 'assets/images/product_4.png',
      isFavorite: false,
    ),
  ];
}
