import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
import '../component/book_component.dart';
import '../component/drawer_component_selected.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitState()) {
    fetchData();
    _loadLanguage();
    _getAllBook();
    //fetchSpecificBook(bookName);
  }

  CategoryNameEntities catName = CategoryNameEntities(categoryName: "");
  BookNameEntities bookName = BookNameEntities(bookName: "");
  List<Book> saveBook = [];
  List<Book> booksCategories = [];
  String? languageValue;

  String? translatedData;
  String? description;
  bool isTranslated = false;
  List<Book> allBook = [];
  List<Book> similarBooks = [];
  Book? book;

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
    print(allBook);
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

  void fetchData() async {
    emit(LoadingCategoryDataState());
    final result = instance<GetBookCategoriesUseCase>();
    final data = await result.call(const NoParameter());

    data.fold((l) {
      emit(ErrorCategoryDataState(failure: l));
      return l.messageError;
    }, (r) {
      emit(LoadedCategoryDataState(data: r));

      return r;
    });
  }

  void fetchBookInCategory(CategoryNameEntities input) async {
    emit(LoadingBookFromCategoryState());
    final result = instance<GetAllBookInOneCategoryUsecase>();
    final data = await result.call(input);

    data.fold((l) {
      emit(ErrorLoadBookFromCategoryState(failure: l));
      return l.messageError;
    }, (r) {
      emit(LoadedBookFromCategoryState(data: r));

      return r;
    });
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

  void getSimilarbook(CategoryNameEntities categoryNameEntities) async {
    final result = instance<GetAllBookInOneCategoryUsecase>();
    final data = await result.call(categoryNameEntities);

    data.fold((l) {}, (r) => saveBook = r);
  }
}