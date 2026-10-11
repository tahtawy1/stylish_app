import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/category/data/data_sources/category_remote_data_source.dart';
import 'package:stylish_app/features/category/domain/entities/category_entity.dart';
import 'package:stylish_app/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    int? limit,
  }) async {
    try {
      final result = await remoteDataSource.getCategories(limit: limit);
      return right(result);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryById({
    required String id,
  }) async {
    try {
      final result = await remoteDataSource.getCategoryById(id: id);
      return right(result);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
