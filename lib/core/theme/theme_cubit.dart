import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final lightTheme = ThemeData.light();

final darkTheme = ThemeData.dark();

/// States for the ThemeCubit
enum ThemeState {
  light,
  dark;
}

/// ThemeCubit to manage the app's theme
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light); // Default theme is light

  /// Toggles between light and dark themes
  void toggleTheme() {
    emit(state == ThemeState.light ? ThemeState.dark : ThemeState.light);
  }

  /// Sets the theme to the selected theme
  void setTheme(final ThemeState selectedTheme) {
    emit(selectedTheme);
  }
}
