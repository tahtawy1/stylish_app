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

  final fits = ['Slim', 'Regular', 'Relaxed', 'Oversized'];

  final materials = [
    'Cotton',
    'Denim',
    'Linen',
    'Leather',
    'Polyester',
    'Fleece',
    'Wool',
  ];

  final colors = ['Black', 'White', 'Navy', 'Gray', 'Beige', 'Olive', 'Brown'];

  final sizes = ['S', 'M', 'L', 'XL', '2XL', '3XL', '4XL'];

  // Last 2 digits of the current year.
  // 2026 -> 26
  final yearCode = (now.year % 100).toString().padLeft(2, '0');

  final dummyProducts = List.generate(50, (index) {
    final docRef = productsCollection.doc();

    final categoryIndex = index ~/ 10;
    final categoryId = categories[categoryIndex];

    final categoryName = categoryId[0].toUpperCase() + categoryId.substring(1);

    final fit = fits[index % fits.length];

    final material = materials[index % materials.length];

    // Generated product name:
    // Fit + Material + Category
    //
    // Example:
    // Oversized Cotton Hoodies
    // Slim Denim Jeans
    // Relaxed Linen Shirts
    final title = '$fit $material $categoryName';

    final collectionId = dummyCollections[index % dummyCollections.length].id;

    final price = 800 + (index * 75).toDouble();

    final discount = index.isEven ? 15.0 : 0.0;

    // ─────────────────────────────────────────────
    // SKU
    //
    // Format:
    // CATEGORY-YEAR-SEQUENCE
    //
    // Example:
    // HOO-26-000001
    // HOO-26-000002
    // JAC-26-000011
    // JEA-26-000021
    // ─────────────────────────────────────────────
    final categoryCode = categoryId.substring(0, 3).toUpperCase();

    final productSequence = (index + 1).toString().padLeft(6, '0');

    final sku = '$categoryCode-$yearCode-$productSequence';

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

        // Fixed for the entire product.
        // Does NOT change with color or size.
        sku: sku,

        // Generated automatically.
        title: title,

        description:
            '$title with a modern and comfortable design. '
            'Perfect for everyday wear with a high-quality finish.',

        categoryId: categoryId,
        collectionId: collectionId,

        // Product material.
        material: material,

        // One price for all color/size combinations.
        price: price,
        discountPercentage: discount,

        averageRating: double.parse(
          (3.8 + (index % 12) * 0.1).toStringAsFixed(1),
        ),

        ratingCount: 15 + index * 4,
        totalSales: 30 + index * 12,
        totalReviewsWithComments: 5 + (index * 2),
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
  final reviewsCollection = firestore.collection('reviews');

  final reviewsBatch = firestore.batch();

  final reviewUsers = [
    'Wade Warren',
    'Guy Hawkins',
    'Robert Fox',
    'Esther Howard',
    'Brooklyn Simmons',
    'Jenny Wilson',
    'Cody Fisher',
    'Kristin Watson',
    'Darlene Robertson',
    'Courtney Henry',
  ];

  final reviewComments = [
    'The item is very good, I really like the quality and design.',
    'The seller was very fast and the item arrived quickly.',
    'The quality is really good and I highly recommend it.',
    'Great quality and comfortable to wear. Would buy again.',
    'The product looks exactly like the pictures. Very satisfied.',
    'Good material and perfect fit. I am happy with my purchase.',
    'Really nice product for the price. Highly recommended.',
    'The quality exceeded my expectations.',
    'Very comfortable and stylish. I love it.',
    'Everything was perfect from the quality to the delivery.',
  ];

  for (
    var productIndex = 0;
    productIndex < dummyProducts.length;
    productIndex++
  ) {
    final product = dummyProducts[productIndex].value;

    final reviewCount = 5 + (productIndex % 6);

    for (var reviewIndex = 0; reviewIndex < reviewCount; reviewIndex++) {
      final userIndex = (productIndex + reviewIndex) % reviewUsers.length;

      final ratingOptions = [5.0, 5.0, 4.0, 4.0, 4.0, 3.0];

      final rating =
          ratingOptions[(productIndex + reviewIndex) % ratingOptions.length];

      final reviewId = '${product.id}_review_$reviewIndex';

      final reviewRef = reviewsCollection
          .doc(product.id)
          .collection('items')
          .doc(reviewId);

      reviewsBatch.set(reviewRef, {
        'id': reviewId,

        'userId': 'user_${userIndex + 1}',

        'userName': reviewUsers[userIndex],

        'rating': rating,

        'comment': reviewComments[userIndex],

        'createdAt': Timestamp.fromDate(
          now.subtract(Duration(days: productIndex + reviewIndex + 1)),
        ),
      });
    }
  }

  await reviewsBatch.commit();
  await batch.commit();

  debugPrint('✅ 50 Dummy Products Added Successfully');
}
