import 'package:flutter/material.dart';

import '../screen/main_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSetings) {
    switch (routeSetings.name) {
      case '/':
      default:
        return MaterialPageRoute(builder: (_) => const MainScreen());
    }
  }
}
