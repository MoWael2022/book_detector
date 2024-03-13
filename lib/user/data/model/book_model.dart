import 'package:khaltabita/user/domin/entites/book_entites.dart';

class BookModel extends Book {
  BookModel(
      {required super.category,
      required super.author,
      required super.averageRating,
      required super.description,
      required super.id,
      required super.numPage,
      required super.publishedYear,
      required super.ratingCount,
      required super.title,
      required super.urlImage});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
        category: json["categories"],
        author: json["authors"],
        averageRating: json["average_rating"],
        description: json["description"],
        id: json['id'],
        numPage: json["num_pages"],
        publishedYear: json["published_year"],
        ratingCount: json["ratings_count"],
        title: json["title"],
        urlImage: json["url_image"]);
  }
}
