import 'package:khaltabita/core/error/category_failure.dart';
import 'package:khaltabita/user/data/model/user_input_model.dart';
import 'package:khaltabita/user/data/model/user_model.dart';
import 'package:khaltabita/user/domin/entites/User.dart';
import 'package:khaltabita/user/domin/entites/categories.dart';
import 'package:dartz/dartz.dart';

import '../entites/book_entites.dart';
import '../entites/category_name_entites.dart';
abstract class BaseRepository {

  Future<Either<Failure,List<Categories>>>getCategoriesRepository();

  Future<Either<Failure,List<Book>>>getBookUsingCategoryRepository(CategoryNameEntities categoryNameEntities);

  Future<Either<Failure,Book>> getSpecificBookRepository(BookNameEntities bookNameEntities);

  Future<Either<Failure,User>> registerRepository(UserInputModel userInputModel);
}