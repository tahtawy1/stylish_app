import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:stylish_app/features/product/data/models/collection_model.dart';
import 'package:stylish_app/features/product/data/models/color_variant_model.dart';
import 'package:stylish_app/features/product/data/models/product_model.dart';
import 'package:stylish_app/features/product/data/models/size_variant_model.dart';

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

  final colors = ['Black', 'White', 'Navy', 'Gray', 'Beige', 'Olive', 'Brown'];

  final sizes = ['S', 'M', 'L', 'XL', '2XL', '3XL', '4XL'];

  final dummyProducts = List.generate(50, (index) {
    final docRef = productsCollection.doc();

    final categoryIndex = index ~/ 10;
    final categoryId = categories[categoryIndex];

    final title = productNames[categoryId]![index % 10];

    final collectionId = dummyCollections[index % dummyCollections.length].id;

    final price = 800 + (index * 75).toDouble();

    final discount = index.isEven ? 15.0 : 0.0;

    // Every product has 3-5 colors.
    final colorCount = 3 + (index % 3);

    final productColors = colors.take(colorCount).toList();

    final colorVariants = <ColorVariantModel>[];

    for (var colorIndex = 0; colorIndex < productColors.length; colorIndex++) {
      final color = productColors[colorIndex];

      // Every color has 4-7 sizes.
      final sizeCount = 4 + ((index + colorIndex) % 4);

      final availableSizes = sizes.take(sizeCount).toList();

      final sizeVariants = <SizeVariantModel>[];

      for (var sizeIndex = 0; sizeIndex < availableSizes.length; sizeIndex++) {
        final size = availableSizes[sizeIndex];

        // Make some sizes unavailable for UI testing.
        final isAvailable =
            !(index % 7 == 0 && sizeIndex == availableSizes.length - 1);

        final quantity = isAvailable
            ? 5 + ((index + colorIndex + sizeIndex) % 20)
            : 0;

        sizeVariants.add(
          SizeVariantModel(
            id: 'size_${index}_${colorIndex}_$sizeIndex',
            size: size,
            quantity: quantity,
            isAvailable: isAvailable,
          ),
        );
      }

      colorVariants.add(
        ColorVariantModel(
          id: 'color_${index}_$colorIndex',
          color: color,

          // Images belong to the color, NOT the size.
          images: [
            'https://picsum.photos/500/500?random=${index + 301 + colorIndex * 10}',
            'https://picsum.photos/500/500?random=${index + 401 + colorIndex * 10}',
            'https://picsum.photos/500/500?random=${index + 501 + colorIndex * 10}',
          ],

          sizes: sizeVariants,
        ),
      );
    }

    return MapEntry(
      docRef,
      ProductModel(
        id: docRef.id,
        title: title,
        description:
            '$title made from premium materials with a modern '
            'and comfortable design. Perfect for everyday wear '
            'with a comfortable fit and high-quality finish.',
        categoryId: categoryId,
        collectionId: collectionId,

        // One price for all color/size combinations.
        price: price,
        discountPercentage: discount,

        averageRating: double.parse(
          (3.8 + (index % 12) * 0.1).toStringAsFixed(1),
        ),

        reviewCount: 15 + index * 4,
        totalSales: 30 + index * 12,
        isAvailable: true,

        // General product images.
        images: [
          'https://picsum.photos/500/500?random=${index + 1}',
          'https://picsum.photos/500/500?random=${index + 101}',
          'https://picsum.photos/500/500?random=${index + 201}',
        ],

        // Product
        //   └── colorVariants
        //         └── sizes
        colorVariants: colorVariants,

        createdAt: now.subtract(Duration(days: index)),
        updatedAt: now,
      ),
    );
  });

  final batch = firestore.batch();

  for (final entry in dummyProducts) {
    batch.set(entry.key, entry.value.toJson());
  }

  await batch.commit();

  debugPrint('✅ 50 Dummy Products Added Successfully');
}
