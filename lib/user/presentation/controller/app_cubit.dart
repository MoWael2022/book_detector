import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khaltabita/core/global_resources/constants.dart';
import 'package:khaltabita/core/service_locator.dart';
import 'package:khaltabita/user/data/model/language_translation_input_model.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';
import 'package:khaltabita/user/domin/usecase/Language_Translation_usecase.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';
import 'package:khaltabita/user/domin/usecase/get_all_book_in_one_category_usecase.dart';
import 'package:khaltabita/user/domin/usecase/get_all_book_usecase.dart';
import 'package:khaltabita/user/domin/usecase/get_book_categories.dart';
import 'package:khaltabita/user/domin/usecase/get_specific_book_usecase.dart';
import 'package:khaltabita/user/presentation/component/drawer_component.dart';
import 'package:khaltabita/user/presentation/controller/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/enums.dart';
import '../../domin/entites/book_entites.dart';
import '../../domin/entites/categories.dart';
import '../../domin/usecase/connectivity_usecase.dart';
import '../../domin/usecase/get_category_image.dart';
import '../component/book_component.dart';
import '../component/drawer_component_selected.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitState()) {
    initConnectivity();
    //fetchData();
    _loadLanguage();
    _getAllBook();
    //fetchSpecificBook(bookName);
  }

  CategoryNameEntities catName = CategoryNameEntities(categoryName: "");
  BookNameEntities bookName = BookNameEntities(bookName: "");

  //final ConnectivityUseCase _connectivityUseCase;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  List<Book> saveBook = [];
  List<Book> booksInCategories = [];
  String? languageValue;

  String? translatedData;
  String? description;
  bool isTranslated = false;
  List<Book> allBook = [];
  List<Book> similarBooks = [];
  Book? book;

  List<Categories> categories = [];

  Map<String, String> allCategoryData = {};
  final int _itemsPerPage = 10;

  void getSimilarbook(CategoryNameEntities categoryNameEntities) async {
    final result = instance<GetAllBookInOneCategoryUsecase>();
    final data = await result.call(categoryNameEntities);

    data.fold((l) {}, (r) => saveBook = r);
  }

  Future<Map<String, String>> getAllCategoryData() async {
    final result = instance<GetCategoryImageUseCase>();
    for (var cat in categories.take(7).toList()) {
      final data = await result.call(cat.categoryName);
      data.fold(
        (l) {},
        (r) {
          allCategoryData[cat.categoryName] = r.categoryImage;
        },
      );
    }
    return allCategoryData;
  }

  getImagesForCategoryHome(){

  }

  fetchInitialBooks() {}

  Future<void> initConnectivity() async {
    final data = instance<ConnectivityUseCase>();
    final result = await data.call(const NoParameter());

    result.fold(
      (failure) => emit(ConnectivityFailure(failure.messageError)),
      (isConnected) {
        emit(isConnected
            ? ConnectivitySuccess()
            : ConnectivityFailure('No internet connection'));
      },
    );
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(connectivityChanged);
  }

  void connectivityChanged(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      emit(ConnectivityFailure('No internet connection'));
    } else {
      emit(ConnectivitySuccess());
    }
  }

  Future<List<Book>> getAllBooksFuture() async {
    if (allBook.isEmpty) {
      final result = instance<GetAllBookUseCase>();
      final data = await result.call(const NoParameter());
      data.fold(
        (l) {
          throw Exception(l.messageError);
        },
        (r) {
          allBook = r;
        },
      );
    }
    return allBook;
  }

  _getAllBook() async {
    final result = instance<GetAllBookUseCase>();
    final data = await result.call(const NoParameter());
    data.fold((l) {
      return l.messageError;
    }, (r) {
      //print(r);
      allBook = r;
    });
  }

  getSimilarBook(String book) {
    //print(allBook);
    similarBooks = allBook
        .where((element) =>
            element.title.toLowerCase().contains(book.toLowerCase()))
        .toList();
    //similarBook = allBook.where((element) => element.title.contains(book)).toList();
  }

  Future<String> translationLanguage(String query) async {
    //emit(TranslationStateLoading());
    final result = await instance<LanguageTranslationUseCase>()
        .call(LanguageTranslationInputModel(query: query));
    result.fold(
      (failure) {
        emit(TranslationStateError());
        return failure.messageError;
      },
      (translation) {
        // Update translated description here
        description = translation.translatedText;
        //emit(TranslationStateLoaded(translatedData: translation.translatedText));
      },
    );
    return '';
  }

  _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    languageValue = prefs.getString("language") ?? "ar";
    emit(ChangeLanguage(languageValue!));
  }

  Future<void> changeLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", language);
    languageValue = language;
    emit(ChangeLanguage(language));
  }

  Future<List<Categories>> fetchData() async {
    emit(LoadingCategoryDataState());
    final result = instance<GetBookCategoriesUseCase>();
    final data = await result.call(const NoParameter());

    data.fold((l) {
      emit(ErrorCategoryDataState(failure: l));
      return l.messageError;
    }, (r) {
      emit(LoadedCategoryDataState(data: r));
      categories = r;
      return r;
    });
    return categories;
  }

  Future<List<Book>> fetchBookInCategory(CategoryNameEntities input) async {
    emit(LoadingBookFromCategoryState());
    final result = instance<GetAllBookInOneCategoryUsecase>();
    final data = await result.call(input);

    data.fold((l) {
      emit(ErrorLoadBookFromCategoryState(failure: l));
      return l.messageError;
    }, (r) {
      emit(LoadedBookFromCategoryState(data: r));
      booksInCategories = r;
      return r;
    });
    return booksInCategories;
  }

  void fetchSpecificBook(BookNameEntities input) async {
    emit(LoadingBookState());
    final result = instance<GetSpecificBookUsecase>();
    final data = await result.call(input);

    data.fold((l) {
      emit(ErrorLoadBookState(failure: l));
      return l.messageError;
    }, (r) {
      book = r;
      emit(LoadedBookState(data: r));
      return r;
    });
  }
}
