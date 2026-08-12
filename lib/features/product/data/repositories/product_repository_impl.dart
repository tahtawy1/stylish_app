import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:stylish_app/features/product/domain/entities/paginated_result.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/entities/product_filter_model.dart';
import 'package:stylish_app/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productDataSource;

  ProductRepositoryImpl({required this.productDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final products = await productDataSource.getAllProducts();
      return Right(List<ProductEntity>.from(products));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResult<ProductEntity>>>
  getNewArrivalsProducts({
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    ProductFilterModel? filter,
  }) async {
    try {
      final result = await productDataSource.getNewArrivalsProducts(
        limit: limit,
        lastDocument: lastDocument,
        filter: filter,
      );
      return Right(
        PaginatedResult(
          items: List<ProductEntity>.from(result.items),
          lastDocument: result.lastDocument,
          hasMore: result.hasMore,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResult<ProductEntity>>>
  getBestSellersProducts({
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    ProductFilterModel? filter,
  }) async {
    try {
      final result = await productDataSource.getBestSellersProducts(
        limit: limit,
        lastDocument: lastDocument,
        filter: filter,
      );
      return Right(
        PaginatedResult(
          items: List<ProductEntity>.from(result.items),
          lastDocument: result.lastDocument,
          hasMore: result.hasMore,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResult<ProductEntity>>> getOnSaleProducts({
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    ProductFilterModel? filter,
  }) async {
    try {
      final result = await productDataSource.getOnSaleProducts(
        limit: limit,
        lastDocument: lastDocument,
        filter: filter,
      );
      return Right(
        PaginatedResult(
          items: List<ProductEntity>.from(result.items),
          lastDocument: result.lastDocument,
          hasMore: result.hasMore,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById({
    required String id,
  }) async {
    try {
      final product = await productDataSource.getProductById(id: id);
      return Right(product);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResult<ProductEntity>>>
  getProductsByCategory({
    required String categoryId,
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    ProductFilterModel? filter,
  }) async {
    try {
      final result = await productDataSource.getProductsByCategory(
        categoryId: categoryId,
        limit: limit,
        lastDocument: lastDocument,
        filter: filter,
      );
      return Right(
        PaginatedResult(
          items: List<ProductEntity>.from(result.items),
          lastDocument: result.lastDocument,
          hasMore: result.hasMore,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
