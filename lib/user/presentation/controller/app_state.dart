import 'package:khaltabita/user/domin/entites/book_entites.dart';

import '../../../core/error/category_failure.dart';
import '../../domin/entites/categories.dart';

abstract class AppState {}

class InitState extends AppState {}

class LoadingCategoryDataState extends AppState {}

class LoadedCategoryDataState extends AppState {
  List<Categories> data;

  LoadedCategoryDataState({required this.data});
}

class ErrorCategoryDataState extends AppState {
  Failure failure;

  ErrorCategoryDataState({required this.failure});
}

class LoadingBookFromCategoryState extends AppState {}

class LoadedBookFromCategoryState extends AppState {
  List<Book> data;

  LoadedBookFromCategoryState({required this.data});
}

class ErrorLoadBookFromCategoryState extends AppState {
  Failure failure;

  ErrorLoadBookFromCategoryState({required this.failure});
}
