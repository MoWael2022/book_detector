import 'package:dio/dio.dart';
import 'package:khaltabita/core/error/category_exceptions.dart';
import 'package:khaltabita/core/global_resources/constants.dart';
import 'package:khaltabita/user/data/data_source/base_remote_data_source.dart';
import 'package:khaltabita/user/data/model/book_model.dart';
import 'package:khaltabita/user/data/model/categories_model.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';

class RemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<List<CategoryModel>> getCategories() async {
    Dio dio = Dio();
    print('--------------------------');
    final response = await dio.get(AppConstants.categoriesPath);
    print('--------------------------');
    //print("->>>>>${response.data}");

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;

      List<CategoryModel> categories =
          data.map((json) => CategoryModel.fromJson(json)).toList();

      List<CategoryModel> result = [];
      for (var category in categories) {
        if (category != null) {
          result.add(category);
          //print(category.categoryName);
        }
      }
      return result;
    } else {
      throw CategoryServerException(errorMessage: "something is wrong ");
    }
  }

  @override
  Future<List<BookModel>> getBookUsingCategoriesDataSource(
      CategoryNameEntities inputForUsecase) async {
    Dio dio = Dio();
    String path = AppConstants.booksInCategory(inputForUsecase.categoryName);
    final response = await dio.get(path);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;

      List<BookModel> bookModel =
          data.map((json) => BookModel.fromJson(json)).toList();

      List<BookModel> result = [];
      for (var element in bookModel) {
        if (element != null) {
          result.add(element);
          //print(category.categoryName);
        }
      }
      return result;
    } else {
      throw CategoryServerException(errorMessage: "something is wrong ");
    }
  }
}
