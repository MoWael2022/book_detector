import 'package:khaltabita/user/domin/entites/categories.dart';

class AppConstants {
  static const String baseURL = "https://demobookdetector.azurewebsites.net";
  static const categoriesPath = "$baseURL/book/viewcategorie";
  static const registerPath = "$baseURL/register";

  static String booksInCategory(String categoryName) =>
      "$baseURL/book/categorie/$categoryName";

  static String getSpecificBook(String bookName) =>
      "$baseURL/book/title/$bookName";


}
