
import 'package:flutter/material.dart';

class SystemTheme extends ChangeNotifier {
  ThemeMode theme = ThemeMode.system;

  void toggleTheme() {

      theme = switch (theme) {
        ThemeMode.system => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.light,
        ThemeMode.light => ThemeMode.system,
      };

      debugPrint('Theme changed to $theme');

      notifyListeners();
  } 
}