import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:stylish_app/features/cart/data/models/cart_item_model.dart';

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final FirebaseFirestore firestore;

  CartRemoteDataSourceImpl({required this.firestore});
  @override
  Future<void> addToCart({
    required CartItemModel item,
    required String userId,
  }) async {
    try {
      final itemSnap = await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(item.id)
          .get();
      if (itemSnap.exists) {
        final existingItem = CartItemModel.fromJson(itemSnap.data()!);
        await itemSnap.reference.update({
          'quantity': existingItem.quantity + item.quantity,
        });
      } else {
        await itemSnap.reference.set(item.toJson());
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CartItemModel>> getCartItems({required String userId}) async {
    try {
      final snap = await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();
      return snap.docs
          .map((doc) => CartItemModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> incrementCartItemQuantity({
    required String userId,
    required String itemId,
  }) async {
    try {
      final itemSnap = await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(itemId)
          .get();
      if (itemSnap.exists) {
        final item = CartItemModel.fromJson(itemSnap.data()!);
        await itemSnap.reference.update({'quantity': item.quantity + 1});
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> decrementCartItemQuantity({
    required String userId,
    required String itemId,
  }) async {
    try {
      final itemSnap = await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(itemId)
          .get();
      if (itemSnap.exists) {
        final item = CartItemModel.fromJson(itemSnap.data()!);
        if (item.quantity > 1) {
          await itemSnap.reference.update({'quantity': item.quantity - 1});
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart({
    required String userId,
    required String itemId,
  }) async {
    try {
      final itemSnap = await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(itemId)
          .get();
      if (itemSnap.exists) {
        await itemSnap.reference.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
