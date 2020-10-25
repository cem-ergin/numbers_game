import 'package:flutter/material.dart';
import 'package:sayiciklar/pages/auth/auth_loading_page.dart';
import 'package:sayiciklar/pages/auth/login_page.dart';
import 'package:sayiciklar/pages/auth/sign_up_page.dart';
import 'package:sayiciklar/pages/error/error_page.dart';
import 'package:sayiciklar/pages/home/guess_page.dart';
import 'package:sayiciklar/pages/home/home_page.dart';
import 'package:sayiciklar/pages/home/play_with_computer_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => AuthLoadingPage(),
          settings: RouteSettings(name: "/"),
        );
      case "/loginPage":
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
          settings: RouteSettings(name: "/loginPage"),
        );
      case "/signUpPage":
        return MaterialPageRoute(
          builder: (context) => SignUpPage(),
          settings: RouteSettings(name: "/signUpPage"),
        );
      case "/homePage":
        return MaterialPageRoute(
          builder: (context) => MyHomePage(),
          settings: RouteSettings(name: "/homePage"),
        );
      case "/playWithComputerPage":
        return MaterialPageRoute(
          builder: (context) => PlayWithComputerPage(),
          settings: RouteSettings(name: "/playWithComputerPage"),
        );
      case "/guessPage":
        return MaterialPageRoute(
          builder: (context) => GuessPage(),
          settings: RouteSettings(name: "/guessPage"),
        );
      default:
        return MaterialPageRoute(builder: (context) => ErrorPage());
    }
  }
}
