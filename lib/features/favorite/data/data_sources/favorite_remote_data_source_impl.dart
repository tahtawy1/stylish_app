import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylish_app/features/favorite/data/data_sources/favorite_remote_data_source.dart';

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  FavoriteRemoteDataSourceImpl({required this.firestore, required this.auth});

  @override
  Future<void> addToFavorite({required String productId}) async {
    try {
      log('add to favorite: $productId');

      if (auth.currentUser == null) {
        log('user = null');
        throw Exception('user = null');
      }
      final uid = auth.currentUser!.uid;
      log('add to favorite: $productId');
      await firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .doc(productId)
          .set({
            'productId': productId,
            'addedAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      log('add to favorite error: $e');
      rethrow;
    }
  }

  @override
  Future<void> removeFavorite({required String productId}) async {
    try {
      if (auth.currentUser == null) {
        throw Exception('user = null');
      }
      final uid = auth.currentUser!.uid;
      await firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .doc(productId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Set<String>> getUserFavoriteProductsIds() async {
    try {
      if (auth.currentUser == null) {
        throw Exception('user = null');
      }
      final uid = auth.currentUser!.uid;
      final snapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .get();
      return snapshot.docs.map((doc) => doc.id).toSet();
    } catch (e) {
      rethrow;
    }
  }
}
