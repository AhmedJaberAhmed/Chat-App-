
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeData> {
  bool _isDarkMode = false;

  ThemeCubit() : super(lightMode);

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    if (_isDarkMode) {
      emit(darkMode);
    } else {
      emit(lightMode);
    }
  }
}

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    // very dark - app bar + drawer color
    surface: Color.fromARGB(255, 9, 9, 9),
    // slightly light
    primary: Color.fromARGB(255, 105, 105, 105),
    // dark
    secondary: Color.fromARGB(255, 20, 20, 20),
    // slightly dark
    tertiary: Color.fromARGB(255, 29, 29, 29),
    // very light
    inversePrimary: Color.fromARGB(255, 195, 195, 195),
  ), // ColorScheme.dark
  scaffoldBackgroundColor: const Color.fromARGB(255, 9, 9, 9),
); // ThemeData




ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.grey.shade100,
    inversePrimary: Colors.grey.shade900,
  ), // ColorScheme.light
  scaffoldBackgroundColor: Colors.grey.shade300,
); // ThemeData
