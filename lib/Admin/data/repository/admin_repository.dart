import 'package:dartz/dartz.dart';
import 'package:khaltabita/Admin/data/datasource/base_remote_data_source.dart';
import 'package:khaltabita/Admin/data/model/book_data_model.dart';
import 'package:khaltabita/Admin/domin/entites/book_data_entites.dart';
import 'package:khaltabita/Admin/domin/repository/base_admi_repository.dart';
import 'package:khaltabita/core/error/Authontication_exception.dart';
import 'package:khaltabita/core/error/category_failure.dart';

import '../../domin/entites/book_data_input.dart';

class AdminRepository extends BaseAdminRepository {
  final BaseAdminRemoteDataSource _baseRemoteDataSource;

  AdminRepository(this._baseRemoteDataSource);

  @override
  Future<Either<Failure, BookData>> addBookRepository(
      BookDataInput bookData, String token) async {
    final result = await _baseRemoteDataSource.addBook(bookData, token);
    try {
      return Right(result);
    } on AuthenticationException catch (failure) {
      return Left(ServerError(failure.errorModel.messageError));
    }
  }

  @override
  Future<Either<Failure, BookData>> deleteBookRepository(
      String token, String id) async {
    final result = await _baseRemoteDataSource.deleteBook(token, id);
    try{
      return Right(result);
    } on AuthenticationException catch (failure) {
      return Left(ServerError(failure.errorModel.messageError));
    }
  }

  @override
  Future<Either<Failure, BookData>> updateBookRepository(
      BookDataInput bookData, String token, String id) async{
    final result = await _baseRemoteDataSource.updateBook(bookData,token, id);
    try{
      return Right(result);
    } on AuthenticationException catch (failure) {
      return Left(ServerError(failure.errorModel.messageError));
    }
  }
}
