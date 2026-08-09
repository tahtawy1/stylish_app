import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/category/domain/entities/category_entity.dart';
import 'package:stylish_app/features/category/domain/repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase({required this.repository});

  Future<Either<Failure, List<CategoryEntity>>> call({int? limit}) async {
    return await repository.getCategories(limit: limit);
  }
}
