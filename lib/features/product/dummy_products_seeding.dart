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

  final dummyProducts = List.generate(10, (index) {
    final docRef = productsCollection.doc();
    final collectionId = dummyCollections[index % dummyCollections.length].id;

    final product = ProductModel(
      id: docRef.id,
      title: 'Nike Air Max ${index + 1}',
      description: 'Comfortable running shoes with modern design.',
      categoryId: 'shoes',
      price: 2500.0 + (index * 150),
      discountPercentage: index.isEven ? 10.0 : 0.0,
      averageRating: double.parse((4.2 + (index % 5) * 0.1).toStringAsFixed(1)),
      reviewCount: 20 + index * 5,
      isAvailable: true,
      images: [
        'https://picsum.photos/500/500?random=${index + 1}',
        'https://picsum.photos/500/500?random=${index + 11}',
        'https://picsum.photos/500/500?random=${index + 21}',
      ],
      variants: [
        VariantModel(
          id: 'v1',
          color: 'White',
          size: '42',
          price: 2500.0 + (index * 150),
          quantity: 8,
          isAvailable: true,
          images: ['https://picsum.photos/500/500?random=${index + 31}'],
        ),
        VariantModel(
          id: 'v2',
          color: 'Black',
          size: '43',
          price: 2600.0 + (index * 150),
          quantity: 4,
          isAvailable: true,
          images: ['https://picsum.photos/500/500?random=${index + 41}'],
        ),
      ],
      collectionId: collectionId,
      createdAt: now,
      updatedAt: now,
    );

    return MapEntry(docRef, product);
  });

  final batch = firestore.batch();

  for (final entry in dummyProducts) {
    batch.set(entry.key, entry.value.toJson());
  }

  await batch.commit();

  debugPrint('✅ 10 Dummy Products with Collections Added Successfully');
}
