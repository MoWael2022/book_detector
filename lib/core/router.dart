import 'package:flutter/material.dart';

class Router {
  static const String splashScreen = "/";
  static const String homePage = "/home";
  static const String login = "/login";
  static const String register = "/register";
  static const String onBoarding = "/onBoarding";
  static const String bookDescription = "/bookDescription";
  static const String bookDetection = "/bookDetection";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings) {
      case Router.splashScreen:
        return unDefinedRoute();
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
