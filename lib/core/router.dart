import 'package:flutter/material.dart';
import 'package:khaltabita/Admin/presentation/screens/all_book_page.dart';
import 'package:khaltabita/Admin/presentation/screens/all_user_page.dart';
import 'package:khaltabita/Admin/presentation/screens/manage_page.dart';
import 'package:khaltabita/Admin/presentation/screens/update_book.dart';
import 'package:khaltabita/user/presentation/screen/Gemini_chat.dart';
import 'package:khaltabita/user/presentation/screen/Similarbook.dart';
import 'package:khaltabita/user/presentation/screen/all_book.dart';
import 'package:khaltabita/user/presentation/screen/book_description.dart';
import 'package:khaltabita/user/presentation/screen/book_detection.dart';
import 'package:khaltabita/user/presentation/screen/Categories.dart';
import 'package:khaltabita/user/presentation/screen/chatbot.dart';
import 'package:khaltabita/user/presentation/screen/first_splash.dart';
import 'package:khaltabita/user/presentation/screen/home.dart';
import 'package:khaltabita/user/presentation/screen/login.dart';
import 'package:khaltabita/user/presentation/screen/setting.dart';
import 'package:khaltabita/user/presentation/screen/second_splash.dart';

import '../Admin/presentation/screens/manage_book.dart';
import '../user/presentation/screen/books_category.dart';
import '../user/presentation/screen/profile.dart';
import '../user/presentation/screen/register.dart';

class Routers {
  //user
  static const String firstSplashScreen = "/";
  static const String secondSplashScreen = "/secondSplash";
  static const String booksCategory = "/booksCategory";
  static const String categories = "/Categories";
  static const String home = "/Home";
  static const String login = "/login";
  static const String register = "/register";
  static const String profile = "/Profile";
  static const String settings = "/Settings";
  //static const String onBoarding = "/onBoarding";
  static const String bookDescription = "/bookDescription";
  static const String bookDetection = "/bookDetection";
  static const String chatBot = "/chatBot";
  static const String similarBook = "/SimilarBook";
  static const String allUserBook = "/allUserBook";
  static const String geminiChat = "/gemini";

  //admin
  static const String managePage = "/Manage";
  static const String manageBook = "/ManageBook";
  static const String updateBook = "/updateBook";
  static const String allAdminBook = "/allAdminBook";
  static const String allAdminUser = "/allAdminUser";





}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routers.firstSplashScreen:
        return MaterialPageRoute(builder: (context) => const FirstSplashScreen());
      case Routers.secondSplashScreen:
        return MaterialPageRoute(builder: (context) => const SecondSplashScreen());
      case Routers.categories:
        return MaterialPageRoute(builder: (context) => const CategoriesPage());
      case Routers.home:
        return MaterialPageRoute(builder: (context) => const HamePage());
      case Routers.bookDescription:
        return MaterialPageRoute(builder: (context) => const BookDescription());
      case Routers.booksCategory:
        return MaterialPageRoute(
            builder: (context) => const BookCategoryPage());
      case Routers.login:
        return MaterialPageRoute(builder: (context) => const Login());
      case Routers.register:
        return MaterialPageRoute(builder: (context) => const SignUp());
      case Routers.profile:
        return MaterialPageRoute(builder: (context) => const Profile());
      case Routers.bookDetection:
        return MaterialPageRoute(builder: (context) =>  BookDetection());
      case Routers.settings:
        return MaterialPageRoute(builder: (context) => const Settings());
      case Routers.managePage:
        return MaterialPageRoute(builder: (context) => const ManagePage());
      case Routers.manageBook:
        return MaterialPageRoute(builder: (context) => const ManageBook());
      case Routers.chatBot:
        return MaterialPageRoute(builder: (context) => const ChatBot());
      case Routers.geminiChat:
        return MaterialPageRoute(builder: (context) => const GeminiChat());
      case Routers.similarBook:
        return MaterialPageRoute(builder: (context) => const SimilarBook());
      case Routers.allAdminBook:
        return MaterialPageRoute(builder: (context) => const AllBookAdminPage());
      case Routers.allUserBook:
        return MaterialPageRoute(builder: (context) => const AllBookUserPage());
      case Routers.allAdminUser:
        return MaterialPageRoute(builder: (context) => const AllUser());
      case Routers.updateBook:
        return MaterialPageRoute(builder: (context) => const UpdateBookPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("No Route Found"),
              ),
              body: const Center(
                child: Text("No Route Found"),
              ),
            ));
  }
}
