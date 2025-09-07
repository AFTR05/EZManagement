import 'package:ezmanagement/src/presentation/ui/pages/auth/login_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/first_boot_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/main_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/screens/configuration/password_manager_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/screens/configuration/role_management/role_management_screen.dart';
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
  static const String config = "/config";
  static const String passwordManager = "/password-manager";
  static const String configRoles = "/config/roles";
  static const String configUsers = "/config/users";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case index:
        return MaterialPageRoute(builder: (_) => const FirstBootScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case editProfile:
        return MaterialPageRoute(builder: (_) => const ProfileEditScreen());
      case config:
        return MaterialPageRoute(builder: (_) => const ProfileSettingsScreen());
      case passwordManager:
        return MaterialPageRoute(builder: (_) => const PasswordManagerScreen());
      case configRoles:
        return MaterialPageRoute(builder: (_) => const RoleManagementScreen());
      case configUsers:
        return MaterialPageRoute(builder: (_) => const RoleManagementScreen());
      default:
        return MaterialPageRoute(builder: (_) => const NoRouteScreen());
    }
  }
}
