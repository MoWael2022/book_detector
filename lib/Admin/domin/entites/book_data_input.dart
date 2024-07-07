import 'package:khaltabita/Admin/domin/entites/book_data_entites.dart';

class BookDataInput {


  String title;

  String categories;

  String authors;

  String description;
  String publishYear;

  String averageRating;
  String ratingsCount;
  String numOfPage;
  String urlImage;

  BookDataInput({

    required this.authors,
    required this.categories,
    required this.title,
    required this.urlImage,
    required this.averageRating,
    required this.description,
    required this.numOfPage,
    required this.publishYear,
    required this.ratingsCount,
  });

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