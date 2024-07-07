import 'package:khaltabita/user/domin/entites/categories.dart';

class AppConstants {
  static const String baseURL = "https://demobookdetector.azurewebsites.net";
  static const categoriesPath = "$baseURL/book/viewcategorie";
  static const registerPath = "$baseURL/register";
  static const loginPath = "$baseURL/login";
  static const adminId = "66ff7d5b-f3ea-46bc-9284-a009e2746628";
  static const addBook = "$baseURL/book/add";
  static const translationPath =
      "https://deep-translate1.p.rapidapi.com/language/translate/v2";
  static const translationKey =
      "23f1d1d96emsh9c94243b163aefbp14dc39jsnf3b6c038c637";

  static String updateBook(String id) => "$baseURL/book/update/$id";

  static String deleteBook(String id) => "$baseURL/book/delete/id/$id";

  static String booksInCategory(String categoryName) =>
      "$baseURL/book/categorie/$categoryName";

  static String getSpecificBook(String bookName) =>
      "$baseURL/book/title/$bookName";

  static const String photoId =
      "936961193812-p48mejrg4lqqjac1e62gmu5hiubp759i.apps.googleusercontent.com";
  static const String getAllBook = "$baseURL/book/viewtitle";
}
