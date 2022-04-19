import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/color_styles.dart';

class AppTheme {
  const AppTheme();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: VkBackground.content.light,
    primaryColorLight: VkBackground.contentTintBackground.light,
    backgroundColor: VkBackground.contentTintBackground.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: IconThemeData(
      color: VKTabBar.activeIcon.light,
    ),
    secondaryHeaderColor: VKHeader.alternateBackground.light,
    tabBarTheme: TabBarTheme(
      labelColor: VKTabBar.activeIcon.light,
      unselectedLabelColor: VKTabBar.inactiveIcon.light,
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: VkBackground.content.light,
      barBackgroundColor: VKTabBar.background.light,
    ),
    sliderTheme: SliderThemeData(
      thumbColor: VKButton.buttonCommerceForeground.light,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: VkBackground.content.dark,
    primaryColorDark: VkBackground.contentTintBackground.dark,
    backgroundColor: VkBackground.contentTintBackground.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: IconThemeData(
      color: VKTabBar.activeIcon.dark,
    ),
    secondaryHeaderColor: VKHeader.alternateBackground.dark,
    tabBarTheme: TabBarTheme(
      labelColor: VKTabBar.activeIcon.dark,
      unselectedLabelColor: VKTabBar.inactiveIcon.dark,
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: VkBackground.content.dark,
      barBackgroundColor: VKTabBar.background.dark,
    ),
    sliderTheme: SliderThemeData(
      thumbColor: VKButton.buttonCommerceForeground.dark,
    ),
  );

  static setStatusBarAndNavigationBarColors(bool themeDarkMode) {
    final themeMode = themeDarkMode ? ThemeMode.dark : ThemeMode.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light ? VkBackground.content.light : VkBackground.content.dark,
      systemNavigationBarIconBrightness: themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}
