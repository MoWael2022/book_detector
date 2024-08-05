import 'package:khaltabita/Admin/data/model/book_data_model.dart';
import 'package:khaltabita/Admin/domin/entites/book_data_input.dart';

import '../../domin/entites/book_data_entites.dart';
import '../model/user_data_model.dart';

abstract class BaseAdminRemoteDataSource {
  Future<BookDataModel> addBook(BookDataInput dataBook,String token);

  Future<BookDataModel> updateBook(BookDataInput dataBook,String token,String id);

  Future<BookDataModel> deleteBook(String token,String id);

  Future<List<UserDataModel>> getAllUser(String token);
}
