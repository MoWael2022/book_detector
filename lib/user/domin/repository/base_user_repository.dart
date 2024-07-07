import 'package:khaltabita/core/error/category_failure.dart';
import 'package:khaltabita/user/data/model/user_input_model.dart';
import 'package:khaltabita/user/data/model/user_model.dart';
import 'package:khaltabita/user/domin/entites/User.dart';
import 'package:khaltabita/user/domin/entites/categories.dart';
import 'package:dartz/dartz.dart';
import 'package:khaltabita/user/domin/entites/input_login_data.dart';
import 'package:khaltabita/user/domin/entites/language_translation_output_entities.dart';
import 'package:khaltabita/user/domin/entites/lnaguage_translation_entites.dart';

import '../../data/model/language_translation_input_model.dart';
import '../entites/book_entites.dart';
import '../entites/category_name_entites.dart';
import '../entites/output_data.dart';

abstract class BaseRepository {

  Future<Either<Failure, List<Categories>>> getCategoriesRepository();

  Future<Either<Failure, List<Book>>> getBookUsingCategoryRepository(
      CategoryNameEntities categoryNameEntities);

  Future<Either<Failure, Book>> getSpecificBookRepository(
      BookNameEntities bookNameEntities);

  Future<Either<Failure, User>> registerRepository(
      UserInputModel userInputModel);

  Future<Either<Failure, User>> loginRepository(InputLoginData inputLoginData);

  Future<Either<Failure,
      LanguageTranslationOutputEntities>> languageTranslationRepository(
      LanguageTranslationInputModel languageTranslationInputModel);

  Future<Either<Failure, List<Book>>> getAllBookRepository();
}