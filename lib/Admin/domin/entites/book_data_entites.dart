import 'package:khaltabita/Admin/domin/entites/book_data_input.dart';

class BookData extends BookDataInput {
  int id;

  BookData(
      {required this.id,
      required super.authors,
      required super.categories,
      required super.title,
      required super.urlImage,
      required super.averageRating,
      required super.description,
      required super.numOfPage,
      required super.publishYear,
      required super.ratingsCount});


}
