import 'package:flutter/material.dart';
import 'package:khaltabita/user/presentation/screen/book_description.dart';
import 'package:khaltabita/user/presentation/screen/home.dart';

import '../user/presentation/screen/books_category.dart';

class Routers {
  //static const String splashScreen = "/";
  static const String booksCategory = "/booksCategory";
  static const String homePage = "/";
  //static const String login = "/login";
  //static const String register = "/register";
  //static const String onBoarding = "/onBoarding";
  static const String bookDescription = "/bookDescription";
  //static const String bookDetection = "/bookDetection";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routers.homePage:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case Routers.bookDescription:
        return MaterialPageRoute(builder: (context) => const BookDescription());
      case Routers.booksCategory:
        return MaterialPageRoute(
            builder: (context) => const BookCategoryPage());
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
