import '../../domin/entites/book_data_entites.dart';

abstract class AdminState {}

class InitState extends AdminState {}

class LoadedState extends AdminState {
  final BookData? bookData;
  LoadedState(this.bookData);
}

class LoadingState extends AdminState {}

class ErrorState extends AdminState {}

class ErrorDeleteState extends AdminState {}

class LoadedDeleteState extends AdminState {
  final String bookId;
  LoadedDeleteState(this.bookId);
}

class LoadingDeleteState extends AdminState {}
