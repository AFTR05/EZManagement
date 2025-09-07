import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeApp extends _$ThemeApp {
  @override
  ThemeMode build() => ThemeMode.system;

  void setTheme(ThemeMode mode) => state = mode;

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  Brightness getBrightness(BuildContext context) {
    switch (state) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.system:
        return MediaQuery.of(context).platformBrightness;
    }
  }

  bool isDarkMode(BuildContext context) {
    return getBrightness(context) == Brightness.dark;
  }
}
