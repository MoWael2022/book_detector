import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:khaltabita/core/error/Authontication_exception.dart';
import 'package:khaltabita/core/error/category_exceptions.dart';
import 'package:khaltabita/core/error/error_model.dart';
import 'package:khaltabita/core/global_resources/constants.dart';
import 'package:khaltabita/user/data/data_source/base_remote_data_source.dart';
import 'package:khaltabita/user/data/model/book_model.dart';
import 'package:khaltabita/user/data/model/categories_model.dart';
import 'package:khaltabita/user/data/model/category_image_model.dart';
import 'package:khaltabita/user/data/model/language_tanslation_output_model.dart';
import 'package:khaltabita/user/data/model/language_translation_input_model.dart';
import 'package:khaltabita/user/data/model/output_data_model.dart';
import 'package:khaltabita/user/data/model/user_input_model.dart';
import 'package:khaltabita/user/data/model/user_model.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';
import 'package:http/http.dart' as http;
import 'package:khaltabita/user/domin/entites/input_login_data.dart';

class RemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<List<CategoryModel>> getCategories() async {
    Dio dio = Dio();

    final response = await dio.get(AppConstants.categoriesPath);

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

  @override
  Future<BookModel> getSpecificBookDataSource(
      BookNameEntities bookNameEntities) async {
    Dio dio = Dio();
    String path = AppConstants.getSpecificBook(bookNameEntities.bookName);
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
      return result[0];
    } else {
      throw CategoryServerException(errorMessage: "something is wrong ");
    }
  }

  @override
  Future<UserModel> registerDataSource(UserInputModel userInputModel) async {
    String path = AppConstants.registerPath;
    Map<String, String> formData = userInputModel.toMap();

    final response = await http.post(Uri.parse(path), body: formData);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = UserModel.fromJson(jsonData);
      return data;
    } else {
      final jsonData = json.decode(response.body);
      final data = ErrorModel.fromJson(jsonData, response.statusCode);

      throw AuthenticationException(errorModel: data).errorModel.messageError;
      print('Bad request: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }

  @override
  Future<UserModel> loginDataSource(InputLoginData inputLoginData) async {
    String url = AppConstants.loginPath;
    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";

    FormData formData = FormData.fromMap({
      'Email': inputLoginData.email,
      'password': inputLoginData.password,
      // Add any additional fields if needed
    });
    Response response = await dio.get(url, data: formData);
    if (response.statusCode == 200) {
      //final data = OutputDataModel.fromJson(response.data);
      final data = UserModel.fromJson(response.data);

      return data;
    } else {
      final jsonData = json.decode(response.data);
      final data = ErrorModel.fromJson(jsonData, response.statusCode!);
      throw AuthenticationException(errorModel: data).errorModel.messageError;
    }
  }

  @override
  Future<LanguageTranslationOutputModel> languageTranslationDataSource(
      LanguageTranslationInputModel languageTranslationInputModel) async {
    Dio dio = Dio();
    String path = AppConstants.translationPath;
    final header = {
      "content-type": "application/json",
      "X-RapidAPI-Key": AppConstants.translationKey,
    };
    final body = languageTranslationInputModel.toMap();
    final response = await dio.post(path,
        data: body,
        options: Options(
          headers: header,
        ));
    print(response.data);
    if (response.statusCode == 200) {
      print("done");
      final data = LanguageTranslationOutputModel.fromJson(response.data);
      return data;
    } else {
      throw Exception("bad request");
    }
  }

  @override
  Future<List<BookModel>> getAllBook() async {
    Dio dio = Dio();

    final response = await dio.get(AppConstants.getAllBook);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;

      List<BookModel> bookModel =
          data.map((json) => BookModel.fromJson(json)).toList();

      List<BookModel> result = [];
      for (var element in bookModel) {
        result.add(element);
        //print(category.categoryName);
      }
      return result;
    } else {
      throw CategoryServerException(errorMessage: "something is wrong ");
    }
  }

  @override
  Future<CategoryImageModel> getCategoriesImage(
      String nameCategory) async {
    Dio dio = Dio();
    final response =
        await dio.get(AppConstants.getAllCategoryImage(nameCategory));
    if(response.statusCode ==200){
      final data = CategoryImageModel.fromJson(response.data[0]);
      return data;
    }else {
      throw CategoryServerException(errorMessage: "something is wrong ");
    }
  }
}
