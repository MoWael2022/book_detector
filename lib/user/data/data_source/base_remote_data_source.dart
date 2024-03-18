import 'package:khaltabita/user/data/model/book_model.dart';
import 'package:khaltabita/user/data/model/categories_model.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';

import '../model/user_input_model.dart';
import '../model/user_model.dart';

abstract class BaseRemoteDataSource {
  Future<List<CategoryModel>> getCategories();

  Future<List<BookModel>> getBookUsingCategoriesDataSource(
      CategoryNameEntities categoryNameEntities);

  Future<BookModel> getSpecificBookDataSource(
      BookNameEntities bookNameEntities);

  Future<UserModel> registerDataSource(UserInputModel userInputModel);
}
