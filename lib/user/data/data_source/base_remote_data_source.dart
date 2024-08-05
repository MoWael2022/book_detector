import 'package:khaltabita/user/data/model/book_model.dart';
import 'package:khaltabita/user/data/model/categories_model.dart';
import 'package:khaltabita/user/data/model/category_image_model.dart';
import 'package:khaltabita/user/data/model/language_tanslation_output_model.dart';
import 'package:khaltabita/user/data/model/language_translation_input_model.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';

import '../../domin/entites/input_login_data.dart';
import '../model/output_data_model.dart';
import '../model/user_input_model.dart';
import '../model/user_model.dart';

abstract class BaseRemoteDataSource {
  Future<List<CategoryModel>> getCategories();

  Future<List<BookModel>> getBookUsingCategoriesDataSource(
      CategoryNameEntities categoryNameEntities);

  Future<BookModel> getSpecificBookDataSource(
      BookNameEntities bookNameEntities);

  Future<UserModel> registerDataSource(UserInputModel userInputModel);

  Future<UserModel> loginDataSource(InputLoginData inputLoginData);

  Future<LanguageTranslationOutputModel> languageTranslationDataSource(
      LanguageTranslationInputModel languageTranslationInputModel);


  Future<List<BookModel>> getAllBook();

  Future<CategoryImageModel> getCategoriesImage(String nameCategory);
}
