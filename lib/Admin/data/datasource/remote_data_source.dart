import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:khaltabita/Admin/data/datasource/base_remote_data_source.dart';
import 'package:khaltabita/Admin/data/model/book_data_model.dart';
import 'package:khaltabita/core/global_resources/constants.dart';

import '../../../core/error/Authontication_exception.dart';
import '../../../core/error/error_model.dart';
import '../../domin/entites/book_data_entites.dart';
import '../../domin/entites/book_data_input.dart';

class AdminRemoteDataSource extends BaseAdminRemoteDataSource {
  @override
  Future<BookDataModel> addBook(BookDataInput dataBook,String token) async {
    String path = AppConstants.addBook;
    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    //Map<String, String> formData = data.toMap();

    FormData formData = FormData.fromMap(dataBook.toMap());

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await dio.post(
      path,
      data: formData,
      options: Options(
        headers: headers,
        followRedirects: false,
        maxRedirects: 0,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    print("done1");
    print(response.data);
    if (response.statusCode == 200) {
      print(response.data);
      final data = BookDataModel.fromJson(response.data);

      print("done2");
      return data;
    } else {
      final jsonData = json.decode(response.data);
      final data = ErrorModel.fromJson(jsonData, response.statusCode!);
      throw AuthenticationException(errorModel: data).errorModel.messageError;
    }
  }

  @override
  Future<BookDataModel> updateBook(BookDataInput dataBook, String token,String id) async{
    String path = AppConstants.updateBook(id);
    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    //Map<String, String> formData = data.toMap();

    FormData formData = FormData.fromMap(dataBook.toMap());

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await dio.put(
      path,
      data: formData,
      options: Options(
        headers: headers,
        followRedirects: false,
        maxRedirects: 0,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    print("done1");
    print(response.data);
    if (response.statusCode == 200) {
      print(response.data);
      final data = BookDataModel.fromJsonUpdate(response.data);

      print("done2");
      return data;
    } else {
      final jsonData = json.decode(response.data);
      final data = ErrorModel.fromJson(jsonData, response.statusCode!);
      throw AuthenticationException(errorModel: data).errorModel.messageError;
    }
  }

  @override
  Future<BookDataModel> deleteBook(String token, String id) async{
    String path = AppConstants.deleteBook(id);
    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    //Map<String, String> formData = data.toMap();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await dio.delete(
      path,
      options: Options(
        headers: headers,
        followRedirects: false,
        maxRedirects: 0,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.data);
      final data = BookDataModel.fromJsonDelete(response.data);

      print("done2");
      return data;
    } else {
      final jsonData = json.decode(response.data);
      final data = ErrorModel.fromJson(jsonData, response.statusCode!);
      throw AuthenticationException(errorModel: data).errorModel.messageError;
    }
  }
}
