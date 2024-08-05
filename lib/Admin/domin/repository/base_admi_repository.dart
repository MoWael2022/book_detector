import 'package:dartz/dartz.dart';
import 'package:khaltabita/Admin/domin/entites/book_data_entites.dart';
import 'package:khaltabita/core/error/category_failure.dart';

import '../../data/model/book_data_model.dart';
import '../../data/model/user_data_model.dart';
import '../entites/book_data_input.dart';

abstract class BaseAdminRepository {
  Future<Either<Failure , BookData>> addBookRepository(BookDataInput bookData,String token);
  Future<Either<Failure , BookData>> updateBookRepository(BookDataInput bookData,String token,String id);
  Future<Either<Failure , BookData>> deleteBookRepository(String token,String id);
  Future<Either<Failure , List<UserDataModel>>> getAllUserRepository(String token);
}