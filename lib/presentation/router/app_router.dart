import 'package:flutter/material.dart';

import '../screens/settings_screen.dart';
import '../screens/main_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSetings) {
    switch (routeSetings.name) {
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/':
      default:
        return MaterialPageRoute(builder: (_) => const MainScreen());
    }
  }
}
