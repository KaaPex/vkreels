import 'package:flutter/material.dart';
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

class VKIcon {
  static Style get medium => const Style(dark: gray400, light: steelGray400);
  static Style get secondary => const Style(dark: gray500, light: steelGray300);
  static Style get tertiary => const Style(dark: gray600, light: steelGray150);
  static Style get outlineMedium => const Style(dark: gray300, light: steelGray400);
  static Style get outlineSecondary => const Style(dark: gray400, light: steelGray300);
  static Style get alphaPlaceholder => const Style(dark: gray100, light: Colors.white);
  static Style get mediumAlpha => const Style(dark: whiteAlpha48, light: blackAlpha48);
  static Style get secondaryAlpha => const Style(dark: whiteAlpha36, light: blackAlpha36);
  static Style get tertiaryAlpha => const Style(dark: whiteAlpha24, light: blackAlpha24);
}

class VKCommon {}

class VkContent {
  static Style get tintForeground => const Style(dark: gray400, light: gray450);
}

class VKHeader {
  static Style get alternateBackground => const Style(dark: gray800, light: white);
  static Style get alternateTabActiveIndicator => const Style(dark: gray100, light: azure300);
  static Style get alternateTabActiveText => const Style(dark: gray100, light: black);
  static Style get alternateTabInactiveText => const Style(dark: gray500, light: steelGray300);
  static Style get background => const Style(dark: gray900, light: white);
  static Style get backgroundBeforeBlur => const Style(dark: grayA970, light: white);
  static Style get backgroundBeforeBlurAlternate => const Style(dark: grayA970, light: white);
  static Style get searchFieldBackground => const Style(dark: gray750, light: gray050);
  static Style get searchFieldTint => const Style(dark: gray300, light: steelGray400);
  static Style get tabActiveBackground => const Style(dark: gray600, light: clear);
  static Style get tabActiveText => const Style(dark: gray100, light: black);
  static Style get tabActiveIndicator => const Style(dark: sky300, light: azure300);
  static Style get tabInactiveText => const Style(dark: gray500, light: steelGray300);
  static Style get text => const Style(dark: gray100, light: black);
  static Style get textAlternate => const Style(dark: gray100, light: black);
  static Style get textSecondary => const Style(dark: whiteAlpha60, light: steelGray400);
  static Style get tint => const Style(dark: gray100, light: azure300);
  static Style get tintAlternate => const Style(dark: gray100, light: azure300);
}

class VKTabBar {
  static Style get inactiveIcon => const Style(dark: gray500, light: steelGray300);
  static Style get activeIcon => const Style(dark: white, light: azure350);
  static Style get background => const Style(dark: gray800, light: gray020);
  static Style get tabletActiveIcon => const Style(dark: sky300, light: azure350);
  static Style get tabletBackground => const Style(dark: gray850, light: gray020);
  static Style get tabletInactiveIcon => const Style(dark: gray500, light: steelGray300);
  static Style get tabletTextPrimary => const Style(dark: gray100, light: black);
  static Style get tabletTextSecondary => const Style(dark: gray500, light: gray400);
}
