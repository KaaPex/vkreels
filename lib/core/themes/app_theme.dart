import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/color_styles.dart';

class AppTheme {
  const AppTheme();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: VkContent.tintForeground.light,
    backgroundColor: VkBackground.content.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: VkContent.tintForeground.dark,
    backgroundColor: VkBackground.content.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light ? VkBackground.content.light : VkBackground.content.dark,
      systemNavigationBarIconBrightness: themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}
