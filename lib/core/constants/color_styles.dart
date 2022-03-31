import 'package:flutter/painting.dart';

import 'colors.dart';

class Style {
  final Color dark;
  final Color light;

  const Style({required this.dark, required this.light});
}

class VkAccents {
  static Style get accent => const Style(dark: sky300, light: azure300);
  static Style get destructive => const Style(dark: redLight, light: red);
  static Style get accentAlternate => const Style(dark: white, light: azureA100);
}

class VkBackground {
  static Style get content => const Style(dark: gray900, light: white);
  static Style get page => const Style(dark: gray1000, light: gray050);
  static Style get contentTintBackground => const Style(dark: gray850, light: grayA040);
  static Style get modalCardBackground => const Style(dark: gray800, light: white);
  static Style get light => const Style(dark: gray850, light: gray020);
  static Style get snippetBackground => const Style(dark: gray850, light: white);
  static Style get keyboard => const Style(dark: gray800, light: gray100);
  static Style get suggestions => const Style(dark: gray800, light: white);
  static Style get hover => const Style(dark: white, light: black);
  static Style get highlighted => const Style(dark: whiteAlpha08, light: blackAlpha08);
  static Style get contentWarningBackground => const Style(dark: gray850, light: yellowOverlight);
  static Style get contentPositiveBackground => const Style(dark: greenAlpha, light: greenAlpha);
}

class VkText {
  static Style get primary => const Style(dark: gray100, light: black);
  static Style get muted => const Style(dark: gray200, light: gray800);
  static Style get subhead => const Style(dark: gray400, light: gray500);
  static Style get secondary => const Style(dark: gray500, light: steelGray400);
  static Style get tertiary => const Style(dark: gray600, light: steelGray300);
  static Style get placeholder => const Style(dark: gray300, light: steelGray400);
  static Style get link => const Style(dark: sky300, light: azureA400);
  static Style get name => const Style(dark: gray100, light: azureA400);
  static Style get linkHightlightedBackground => const Style(dark: sky300, light: black);
  static Style get actionCounter => const Style(dark: gray300, light: steelGray400);
}

class VkContent {
  static Style get tintForeground => const Style(dark: gray400, light: gray450);
}
