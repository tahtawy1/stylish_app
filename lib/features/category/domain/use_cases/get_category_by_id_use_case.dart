import 'package:dartz/dartz.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/category/domain/entities/category_entity.dart';
import 'package:stylish_app/features/category/domain/repositories/category_repository.dart';

class GetCategoryByIdUseCase {
  final CategoryRepository categoryRepository;

  GetCategoryByIdUseCase({required this.categoryRepository});

  Future<Either<Failure, CategoryEntity>> call({required String id}) async {
    return await categoryRepository.getCategoryById(id: id);
  }
}
