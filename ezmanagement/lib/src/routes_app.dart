
import 'package:ezmanagement/src/presentation/ui/pages/auth/login_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/main_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/screens/password_manager_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/screens/profile_edit_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/screens/profile_settings_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/no_route_screen.dart';
import 'package:flutter/material.dart';

class RoutesApp {
  static const String index = "/";
  static const String login = "/login";
  static const String home = "/home";
  static const String register = "/register";
  static const String editProfile = "/edit-profile";
  static const String config  = "/config";
  static const String passwordManager = "/password-manager";


static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case index:
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case editProfile: 
        return MaterialPageRoute(builder: (_) => const ProfileEditScreen());
      case config:
        return MaterialPageRoute(builder: (_) => const ProfileSettingsScreen());
      case passwordManager: // caso para administrador de contraseñas
        return MaterialPageRoute(builder: (_) => const PasswordManagerScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const NoRouteScreen()
        );
    }
  }
}
