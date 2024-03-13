import 'package:khaltabita/user/domin/entites/categories.dart';

class AppConstants {

static const String baseURL = "https://demobookdetector.azurewebsites.net";
static const categoriesPath = "$baseURL/book/viewcategorie";
static String booksInCategory (String categoryName)=> "$baseURL/book/categorie/$categoryName";

}