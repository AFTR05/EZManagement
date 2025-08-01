import 'package:ezmanagement/src/presentation/pages/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoutesApp {
  static const String index = "/";
  static const String login = "/login";
  static const String register = "/register";


static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case index:
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
