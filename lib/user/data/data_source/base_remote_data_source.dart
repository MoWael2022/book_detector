import 'package:khaltabita/user/data/model/book_model.dart';
import 'package:khaltabita/user/data/model/categories_model.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';

abstract class BaseRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<BookModel>> getBookUsingCategoriesDataSource(CategoryNameEntities categoryNameEntities);

}
