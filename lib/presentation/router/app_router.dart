import 'package:flutter/material.dart';
import '../page/logo_page.dart';
import '../screens/screens.dart';

class AppRouter {
  static const String main = '/';
  static const String settings = '/settings';
  static const String login = 'login';
  static const String logo = 'logo';

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case login:
        return LoginScreen.route();
      case settings:
        return SettingsScreen.route();
      case main:
        return MainScreen.route();
      case logo:
      default:
        return LogoPage.route();
    }
  }
}
