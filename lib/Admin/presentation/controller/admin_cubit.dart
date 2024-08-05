import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:khaltabita/Admin/domin/entites/book_data_entites.dart';
import 'package:khaltabita/Admin/domin/entites/data_passes_delete.dart';
import 'package:khaltabita/Admin/domin/entites/data_passes_update.dart';
import 'package:khaltabita/Admin/domin/entites/datapasses.dart';
import 'package:khaltabita/Admin/domin/entites/user_data_entites.dart';
import 'package:khaltabita/Admin/domin/usecase/add_book_usecase.dart';
import 'package:khaltabita/Admin/domin/usecase/delete_book_usecase.dart';
import 'package:khaltabita/Admin/domin/usecase/get_all_user_usecase.dart';
import 'package:khaltabita/Admin/presentation/controller/admin_state.dart';
import 'package:khaltabita/core/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domin/entites/book_data_input.dart';
import '../../domin/usecase/update_book_usecase.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(InitState());

  TextEditingController addBookTitle = TextEditingController();
  TextEditingController addBookCategories = TextEditingController();
  TextEditingController addBookAuthors = TextEditingController();
  TextEditingController addBookDescription = TextEditingController();
  TextEditingController addBookPublishYear = TextEditingController();
  TextEditingController addBookAverageRating = TextEditingController();
  TextEditingController addBookRatingCount = TextEditingController();
  TextEditingController addBookNumPage = TextEditingController();
  TextEditingController addBookURL = TextEditingController();

  TextEditingController updateBookTitle = TextEditingController();
  TextEditingController updateBookCategories = TextEditingController();
  TextEditingController updateBookAuthors = TextEditingController();
  TextEditingController updateBookDescription = TextEditingController();
  TextEditingController updateBookPublishYear = TextEditingController();
  TextEditingController updateBookAverageRating = TextEditingController();
  TextEditingController updateBookRatingCount = TextEditingController();
  TextEditingController updateBookNumPage = TextEditingController();
  TextEditingController updateBookURL = TextEditingController();

  BookData? book;
  List<UserDataEntities> users =[];
  String? id;

  void addBook() async {
    emit(LoadingState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("TOKEN");

    try {
      final result = instance<AddBookUseCase>();
      DataPasses dataPasses = DataPasses(
          bookDataInput: BookDataInput(
              authors: addBookAuthors.text,
              categories: addBookCategories.text,
              title: addBookTitle.text,
              urlImage: addBookURL.text,
              averageRating: addBookAverageRating.text,
              description: addBookDescription.text,
              numOfPage: addBookNumPage.text,
              publishYear: addBookPublishYear.text,
              ratingsCount: addBookRatingCount.text),
          token: token ?? '');

      final data = await result.call(dataPasses);

      data.fold((failure) {
        emit(ErrorState());
      }, (bookData) {
        book = bookData;
        emit(LoadedState(bookData));
      });
    } catch (e) {
      emit(ErrorState());
    }
  }

  void updateBook() async {
    emit(LoadingState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("TOKEN");

    try {
      final result = instance<UpdateBookUseCase>();
      DataPassesUpdate dataPasses = DataPassesUpdate(
          id: id!,
          bookDataInput: BookDataInput(
              authors: updateBookAuthors.text,
              categories: updateBookCategories.text,
              title: updateBookTitle.text,
              urlImage: updateBookURL.text,
              averageRating: updateBookAverageRating.text,
              description: updateBookDescription.text,
              numOfPage: updateBookNumPage.text,
              publishYear: updateBookPublishYear.text,
              ratingsCount: updateBookRatingCount.text),
          token: token ?? '');

      final data = await result.call(dataPasses);

      data.fold((failure) {
        emit(ErrorState());
      }, (bookData) {
        book = bookData;
        emit(LoadedState(bookData));
      });
    } catch (e) {
      emit(ErrorState());
    }
  }

  void deleteBook() async {
    emit(LoadingDeleteState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("TOKEN");

    try {
      final result = instance<DeleteBookUseCase>();
      DataPassesDelete dataPasses = DataPassesDelete(
          id: id!,
          token: token ?? '');

      final data = await result.call(dataPasses);

      data.fold((failure) {
        emit(ErrorDeleteState());
      }, (bookData) {
        emit(LoadedDeleteState(id!));
      });
    } catch (e) {
      emit(ErrorDeleteState());
    }
  }

  Future<List<UserDataEntities>> viewAllUser() async {
    emit(LoadingGetUserState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("TOKEN");

    final result = instance<GetAllUserUseCase>();
    final data = await result.call(token!);

    data.fold((l) {
      emit(ErrorGetUserState());
    }, (r) {
      users = r;
      emit(LoadedGetUserState());
    });

    return users;
  }
}
