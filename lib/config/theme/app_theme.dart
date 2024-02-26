import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = true,
  });

  // ignore: empty_constructor_bodies
  ThemeData getTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(centerTitle: false),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    );
  }

  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) =>
      AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
