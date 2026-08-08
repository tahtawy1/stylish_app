import 'package:stylish_app/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  // add product
  // update product
  // delete product
  // get all products
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getNewArrivalsProducts({int limit});
  Future<List<ProductModel>> getBestSellersProducts({int limit});
  Future<List<ProductModel>> getOnSaleProducts({int limit});
  // get product by id
  Future<ProductModel> getProductById({required String id});
  // get products by category
}
