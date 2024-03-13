import 'package:dartz/dartz.dart';
import 'package:khaltabita/user/data/data_source/base_remote_data_source.dart';
import 'package:khaltabita/user/domin/entites/book_entites.dart';
import 'package:khaltabita/user/domin/entites/categories.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';

import '../../../core/error/category_exceptions.dart';
import '../../../core/error/category_failure.dart';

class UserRepository extends BaseRepository {
  final BaseRemoteDataSource _baseRemoteDataSource;

  UserRepository(this._baseRemoteDataSource);

  @override
  Future<Either<Failure, List<Categories>>> getCategoriesRepository() async {
    final result = await _baseRemoteDataSource.getCategories();

    try {
      return Right(result);
    } on CategoryServerException catch (failure) {
      return Left(Failure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getBookUsingCategoryRepository(
      CategoryNameEntities categoryNameEntities) async {
    final result = await _baseRemoteDataSource.getBookUsingCategoriesDataSource(
        categoryNameEntities);

    try {
      return Right(result);
    }on CategoryServerException catch (failure){
      return Left(Failure(failure.errorMessage));
    }
  }
}
