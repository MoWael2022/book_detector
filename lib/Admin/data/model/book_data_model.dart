import 'package:khaltabita/Admin/domin/entites/book_data_entites.dart';

class BookDataModel extends BookData {
  BookDataModel(
      {required super.id,
      required super.authors,
      required super.categories,
      required super.title,
      required super.urlImage,
      required super.averageRating,
      required super.description,
      required super.numOfPage,
      required super.publishYear,
      required super.ratingsCount});

  factory BookDataModel.fromJson(Map<String, dynamic> json) {
    return BookDataModel(
        id: json["addBook"]["id"],
        authors: json["addBook"]["authors"],
        categories: json["addBook"]["categories"],
        title: json["addBook"]["title"],
        urlImage: json["addBook"]["url_image"],
        averageRating: json["addBook"]["average_rating"],
        description: json["addBook"]["description"],
        numOfPage: json["addBook"]["num_pages"],
        publishYear: json["addBook"]["published_year"],
        ratingsCount: json["addBook"]["ratings_count"]);
  }
  factory BookDataModel.fromJsonUpdate(Map<String, dynamic> json) {
    return BookDataModel(
        id: json["id"],
        authors: json["authors"],
        categories: json["categories"],
        title: json["title"],
        urlImage: json["url_image"],
        averageRating: json["average_rating"],
        description: json["description"],
        numOfPage: json["num_pages"],
        publishYear: json["published_year"],
        ratingsCount: json["ratings_count"]);
  }
  factory BookDataModel.fromJsonDelete(Map<String, dynamic> json) {
    return BookDataModel(
        id: json["deletedBook"]["id"],
        authors: json["deletedBook"]["authors"],
        categories: json["deletedBook"]["categories"],
        title: json["deletedBook"]["title"],
        urlImage: json["deletedBook"]["url_image"],
        averageRating: json["deletedBook"]["average_rating"],
        description: json["deletedBook"]["description"],
        numOfPage: json["deletedBook"]["num_pages"],
        publishYear: json["deletedBook"]["published_year"],
        ratingsCount: json["deletedBook"]["ratings_count"]);
  }

  Map<String, String> toMap() {
    return {
      "title": title,
      "categories": categories,
      "authors": authors,
      "description": description,
      "published_year": publishYear,
      "average_rating": averageRating,
      "ratings_count": ratingsCount,
      "num_pages": numOfPage,
      "url_image": urlImage,
    };
  }
}
