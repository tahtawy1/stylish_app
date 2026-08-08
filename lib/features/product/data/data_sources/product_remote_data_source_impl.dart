import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:stylish_app/features/product/data/models/product_model.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final result = await firestore.collection('products').get();
      final products = result.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getNewArrivalsProducts({int limit = 20}) async {
    try {
      final result = await firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();
      final products = result.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getBestSellersProducts({int limit = 20}) async {
    try {
      final result = await firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true)
          .orderBy('totalSales', descending: true)
          .limit(limit)
          .get();
      final products = result.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getOnSaleProducts({int limit = 20}) async {
    try {
      final result = await firestore
          .collection('products')
          .where('isAvailable', isEqualTo: true)
          .where('discountPercentage', isGreaterThan: 0)
          .limit(limit)
          .get();
      final products = result.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById({required String id}) async {
    try {
      final result = await firestore.collection('products').doc(id).get();
      if (result.exists) {
        return ProductModel.fromJson(result.data()!);
      }
      throw Exception('Product not found'); // TODO: add a custom exception
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
