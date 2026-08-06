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
}
