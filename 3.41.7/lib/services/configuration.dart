import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Configuration extends ChangeNotifier {
  static const String _storageKey = 'app_configuration';

  ThemeMode _themeMode = ThemeMode.system;
  int _valorHoraExtraCents = 0;

  ThemeMode get theme => _themeMode;
  
  double get valorHoraExtra => _valorHoraExtraCents / 100.0;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      try {
        final Map<String, dynamic> data = jsonDecode(jsonString);
        
        if (data.containsKey('themeMode')) {
          _themeMode = ThemeMode.values[data['themeMode'] as int];
        }
        
        if (data.containsKey('valorHoraExtra')) {
          _valorHoraExtraCents = data['valorHoraExtra'] as int;
        }
      } catch (e) {
        debugPrint('Error loading configuration: $e');
      }
    }
    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      _save();
      notifyListeners();
    }
  }

  void toggleTheme() {
    _themeMode = switch (_themeMode) {
      ThemeMode.system => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
      ThemeMode.light => ThemeMode.system,
    };
    _save();
    notifyListeners();
  }

  void setValorHoraExtra(double value) {
    final cents = (value * 100).round();
    if (_valorHoraExtraCents != cents) {
      _valorHoraExtraCents = cents;
      _save();
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'themeMode': _themeMode.index,
      'valorHoraExtra': _valorHoraExtraCents,
    };
    await prefs.setString(_storageKey, jsonEncode(data));
  }
}
