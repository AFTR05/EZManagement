import 'package:flutter/material.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: "OpenSansHebrewCondensed",
    primaryColor: EZColorsApp.ezAppColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: EZColorsApp.ezAppColor,
      iconTheme: const IconThemeData(color: EZColorsApp.grayColor),
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
    ),
    canvasColor: Colors.transparent,
    dialogTheme: DialogThemeData(backgroundColor: Colors.white),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: "OpenSansHebrewCondensed",
    primaryColor: EZColorsApp.ezAppColor,
    scaffoldBackgroundColor: EZColorsApp.darkBackgroud,
    appBarTheme: AppBarTheme(
      color: Colors.grey[850],
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
    ),
    cardColor: EZColorsApp.darkBackgroud,
    canvasColor: Colors.transparent,
    dialogTheme: DialogThemeData(backgroundColor: EZColorsApp.darkBackgroud),
  );
}
