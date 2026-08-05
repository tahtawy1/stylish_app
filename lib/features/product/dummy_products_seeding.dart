import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> seedProducts() async {
  final firestore = FirebaseFirestore.instance;
  final products = firestore.collection('products');

  final now = Timestamp.now();

  final dummyProducts = List.generate(10, (index) {
    return {
      'title': 'Nike Air Max ${index + 1}',
      'description': 'Comfortable running shoes.',
      'categoryId': 'shoes',
      'categoryName': 'Shoes',

      'price': 2500 + (index * 150),
      'discountPercentage': index.isEven ? 10 : 0,

      'averageRating': 4.2 + (index % 5) * 0.1,
      'reviewCount': 20 + index * 5,

      'isAvailable': true,

      'mainImage': 'https://picsum.photos/500/500?random=${index + 1}',

      'images': [
        'https://picsum.photos/500/500?random=${index + 1}',
        'https://picsum.photos/500/500?random=${index + 11}',
        'https://picsum.photos/500/500?random=${index + 21}',
      ],

      'variants': [
        {
          'id': 'v1',
          'color': 'White',
          'size': '42',
          'price': null,
          'quantity': 8,
          'isAvailable': true,
          'images': ['https://picsum.photos/500/500?random=${index + 31}'],
        },
        {
          'id': 'v2',
          'color': 'Black',
          'size': '43',
          'price': null,
          'quantity': 4,
          'isAvailable': true,
          'images': ['https://picsum.photos/500/500?random=${index + 41}'],
        },
      ],

      'createdAt': now,
      'updatedAt': now,
    };
  });

  final batch = firestore.batch();

  for (final product in dummyProducts) {
    final doc = products.doc();
    batch.set(doc, product);
  }

  await batch.commit();

  debugPrint('✅ 10 Dummy Products Added');
}
