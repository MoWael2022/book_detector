class Book {
  int id;

  String title;

  String category;

  String author;

  String description;

  String publishedYear;
  String averageRating;
  String ratingCount;

  String numPage;

  String urlImage;

  Book(
      {required this.category,
      required this.author,
      required this.averageRating,
      required this.description,
      required this.id,
      required this.numPage,
      required this.publishedYear,
      required this.ratingCount,
      required this.title,
      required this.urlImage});
}
