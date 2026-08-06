import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HeroSectionEntity {
  final String id;

  final String title;
  final String? subtitle;

  final String imageUrl;

  final HeroActionType actionType;

  final String actionValue;

  final bool isActive;

  final int priority;

  HeroSectionEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.actionType,
    required this.actionValue,
    required this.isActive,
    required this.priority,
  });
}

enum HeroActionType { collection, category, product }

Future<void> seedHeroSections() async {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('hero_sections');

  final now = Timestamp.now();

  final batch = firestore.batch();

  final heroes = [
    {
      'title': 'Summer Collection',
      'subtitle': 'Fresh styles for hot days ☀️',
      'imageUrl':
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f',
      'actionType': HeroActionType.collection.name,
      'actionValue': 'summer',
      'priority': 1,
      'isActive': true,
      'createdAt': now,
    },
    {
      'title': 'Sport Collection',
      'subtitle': 'Move with confidence 🏃',
      'imageUrl':
          'https://images.unsplash.com/photo-1523398002811-999ca8dec234',
      'actionType': HeroActionType.collection.name,
      'actionValue': 'sport',
      'priority': 2,
      'isActive': true,
      'createdAt': now,
    },
    {
      'title': 'Up To 40% OFF',
      'subtitle': 'Limited time offers 🔥',
      'imageUrl':
          'https://images.unsplash.com/photo-1483985988355-763728e1935b',
      'actionType': HeroActionType.collection.name,
      'actionValue': 'summer_sale',
      'priority': 3,
      'isActive': true,
      'createdAt': now,
    },
  ];

  for (final hero in heroes) {
    final doc = collection.doc();
    batch.set(doc, hero);
  }

  await batch.commit();

  debugPrint('✅ Hero Sections Seeded Successfully');
}
