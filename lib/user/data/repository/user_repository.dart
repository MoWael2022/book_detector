import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:khaltabita/core/error/Authontication_exception.dart';
import 'package:khaltabita/user/data/data_source/base_remote_data_source.dart';
import 'package:khaltabita/user/data/data_source/remote_data_source.dart';
import 'package:khaltabita/user/data/model/language_translation_input_model.dart';
import 'package:khaltabita/user/data/model/user_input_model.dart';
import 'package:khaltabita/user/data/model/user_model.dart';
import 'package:khaltabita/user/domin/entites/book_entites.dart';
import 'package:khaltabita/user/domin/entites/categories.dart';
import 'package:khaltabita/user/domin/entites/categoryImage.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';
import 'package:khaltabita/user/domin/entites/input_login_data.dart';
import 'package:khaltabita/user/domin/entites/language_translation_output_entities.dart';
import 'package:khaltabita/user/domin/entites/lnaguage_translation_entites.dart';
import 'package:khaltabita/user/domin/entites/output_data.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../core/error/NetworkFailure.dart';
import '../../../core/error/category_exceptions.dart';
import '../../../core/error/category_failure.dart';
import '../../domin/entites/User.dart';

class UserRepository extends BaseRepository {
  final BaseRemoteDataSource _baseRemoteDataSource;
  //final Connectivity _connectivty;

  UserRepository(this._baseRemoteDataSource);

  @override
  Future<Either<Failure, List<Categories>>> getCategoriesRepository() async {
    final result = await _baseRemoteDataSource.getCategories();

    try {
      return Right(result);
    } on CategoryServerException catch (failure) {
      return Left(Failure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getBookUsingCategoryRepository(
      CategoryNameEntities categoryNameEntities) async {
    final result = await _baseRemoteDataSource
        .getBookUsingCategoriesDataSource(categoryNameEntities);

    try {
      return Right(result);
    } on CategoryServerException catch (failure) {
      return Left(Failure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, Book>> getSpecificBookRepository(
      BookNameEntities bookNameEntities) async {
    final result =
        await _baseRemoteDataSource.getSpecificBookDataSource(bookNameEntities);
    try {
      return Right(result);
    } on CategoryServerException catch (failure) {
      return Left((Failure(failure.errorMessage)));
    }
  }

  @override
  Future<Either<Failure, UserModel>> registerRepository(
      UserInputModel userInputModel) async {
    final result =
        await _baseRemoteDataSource.registerDataSource(userInputModel);

    try {
      return Right(result);
    } on AuthenticationException catch (failure) {
      return Left(ServerError(failure.errorModel.messageError));
    }
  }

  @override
  Future<Either<Failure, User>> loginRepository(
      InputLoginData inputLoginData) async {
    final result = await _baseRemoteDataSource.loginDataSource(inputLoginData);

    try {
      return Right(result);
    } on AuthenticationException catch (failure) {
      return Left(ServerError(failure.errorModel.messageError));
    }
  }

  @override
  Future<Either<Failure, LanguageTranslationOutputEntities>>
      languageTranslationRepository(
          LanguageTranslationInputModel languageTranslationInputModel) async {
    final result = await _baseRemoteDataSource
        .languageTranslationDataSource(languageTranslationInputModel);
    try {
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getAllBookRepository() async {
    final result = await _baseRemoteDataSource.getAllBook();
    try {
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isConnectedRepo() async {
    final Connectivity connectivity = Connectivity();
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      return Right(connectivityResult != ConnectivityResult.none);
    } catch (e) {
      return Left(
          NetworkFailure('Failed to check connectivity: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, CategoryImage>> getCategoryImage(String nameCategory) async{
   final result =await  _baseRemoteDataSource.getCategoriesImage(nameCategory);
   try{
     return Right(result);
   }catch(e){
     return Left(Failure(e.toString()));
   }
  }
}
