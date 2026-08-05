import 'package:stylish_app/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  // add product
  // update product
  // delete product
  // get all products
  Future<List<ProductModel>> getAllProducts();
  // get product by id
  // get products by category
}
