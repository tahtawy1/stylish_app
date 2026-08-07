import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stylish_app/features/product/data/models/collection_model.dart';
import 'package:stylish_app/features/product/data/models/product_model.dart';
import 'package:stylish_app/features/product/data/models/variant_model.dart';

Future<void> seedProducts() async {
  final firestore = FirebaseFirestore.instance;
  final productsCollection = firestore.collection('products');

  final now = DateTime.now();

  final dummyCollections = [
    CollectionModel(
      id: 'col_1',
      name: 'Summer Sale',
      image: 'https://picsum.photos/500/500?random=101',
    ),
    CollectionModel(
      id: 'col_2',
      name: 'New Arrivals',
      image: 'https://picsum.photos/500/500?random=102',
    ),
    CollectionModel(
      id: 'col_3',
      name: 'Trending',
      image: 'https://picsum.photos/500/500?random=103',
    ),
  ];

  final categories = ['hoodies', 'jackets', 'jeans', 'pants', 'shirts'];

  final productNames = {
    'hoodies': [
      'Essential Hoodie',
      'Oversized Hoodie',
      'Classic Hoodie',
      'Sport Hoodie',
      'Urban Hoodie',
      'Premium Hoodie',
      'Zip Hoodie',
      'Cotton Hoodie',
      'Relaxed Hoodie',
      'Street Hoodie',
    ],
    'jackets': [
      'Bomber Jacket',
      'Denim Jacket',
      'Leather Jacket',
      'Puffer Jacket',
      'Windbreaker Jacket',
      'Classic Jacket',
      'Winter Jacket',
      'Casual Jacket',
      'Slim Jacket',
      'Outdoor Jacket',
    ],
    'jeans': [
      'Slim Fit Jeans',
      'Regular Jeans',
      'Skinny Jeans',
      'Straight Jeans',
      'Relaxed Jeans',
      'Blue Jeans',
      'Black Jeans',
      'Vintage Jeans',
      'Classic Jeans',
      'Cargo Jeans',
    ],
    'pants': [
      'Chino Pants',
      'Cargo Pants',
      'Jogger Pants',
      'Slim Pants',
      'Classic Pants',
      'Cotton Pants',
      'Formal Pants',
      'Casual Pants',
      'Relaxed Pants',
      'Track Pants',
    ],
    'shirts': [
      'Oxford Shirt',
      'Linen Shirt',
      'Casual Shirt',
      'Formal Shirt',
      'Slim Shirt',
      'Cotton Shirt',
      'Checked Shirt',
      'Striped Shirt',
      'Classic Shirt',
      'Premium Shirt',
    ],
  };

  final dummyProducts = List.generate(50, (index) {
    final docRef = productsCollection.doc();

    final categoryIndex = index ~/ 10;
    final categoryId = categories[categoryIndex];
    final title = productNames[categoryId]![index % 10];

    final collectionId = dummyCollections[index % dummyCollections.length].id;

    final price = 800 + (index * 75).toDouble();
    final discount = index.isEven ? 15.0 : 0.0;

    final product = ProductModel(
      id: docRef.id,
      title: title,
      description:
          '$title made from premium materials with a modern and comfortable design.',
      categoryId: categoryId,
      collectionId: collectionId,

      price: price,
      discountPercentage: discount,

      averageRating: double.parse(
        (3.8 + (index % 12) * 0.1).toStringAsFixed(1),
      ),

      reviewCount: 15 + index * 4,

      totalSales: 30 + index * 12,

      isAvailable: true,

      images: [
        'https://picsum.photos/500/500?random=${index + 1}',
        'https://picsum.photos/500/500?random=${index + 101}',
        'https://picsum.photos/500/500?random=${index + 201}',
      ],
      variants: [
        VariantModel(
          id: 'v1',
          color: 'White',
          size: '42',
          price: price,
          quantity: 10 + (index % 10),
          isAvailable: true,
          images: ['https://picsum.photos/500/500?random=${index + 301}'],
        ),
        VariantModel(
          id: 'v2',
          color: 'Black',
          size: '43',
          price: price + 100,
          quantity: 5 + (index % 8),
          isAvailable: true,
          images: ['https://picsum.photos/500/500?random=${index + 401}'],
        ),
      ],

      createdAt: now.subtract(Duration(days: index)),
      updatedAt: now,
    );

    return MapEntry(docRef, product);
  });

  final batch = firestore.batch();

  for (final entry in dummyProducts) {
    batch.set(entry.key, entry.value.toJson());
  }

  await batch.commit();

  debugPrint('✅ 50 Dummy Products Added Successfully');
}
