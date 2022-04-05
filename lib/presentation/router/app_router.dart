import 'package:flutter/material.dart';
import '../pages/pages.dart';
import '../screens/screens.dart';

class AppRouter {
  static const String main = MainScreen.routeName;
  static const String stories = '/stories';
  static const String story = StoryDetailPage.routeName;
  static const String search = '/search';
  static const String addStory = '/addStory';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String settings = SettingsScreen.routeName;
  static const String login = LoginScreen.routeName;
  static const String logo = LogoScreen.routeName;

  Route onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == StoryDetailPage.routeName) {
      final args = routeSettings.arguments as StoryDetailsArguments;
    }

    if (routeSettings.name != null) {
      var uri = Uri.parse(routeSettings.name!);
      if (uri.pathSegments.length == 2 && uri.pathSegments.first == stories) {
        var storyId = uri.pathSegments[1];
        // TODO: Add route to story pages
      }
    }

    switch (routeSettings.name) {
      case stories:
        return MainScreen.route();
      case login:
        return LoginScreen.route();
      case settings:
        return SettingsScreen.route();
      case main:
        return MainScreen.route();
      case logo:
      default:
        return LogoScreen.route();
    }
  }
}
