import 'package:flash_news/config/constants/color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = true,
  })  : assert(selectedColor >= 0, 'Selected color must be greater that 0'),
        assert(selectedColor <= colorScheme.length);

  ThemeData getTheme() => ThemeData(
        appBarTheme: const AppBarTheme(centerTitle: false),
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorScheme[selectedColor],
      );

  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) =>
      AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
