import 'package:flutter/material.dart';
import 'package:vk_reels/presentation/screens/login_screen.dart';

import '../screens/settings_screen.dart';
import '../screens/main_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String settings = '/settings';
  static const String login = '/login';

  Route onGenerateRoute(RouteSettings routeSetings) {
    switch (routeSetings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case home:
      default:
        return MaterialPageRoute(builder: (_) => const MainScreen());
    }
  }
}
