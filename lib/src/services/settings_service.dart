import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends ChangeNotifier {
  static const _darkKey = 'dark_mode';
  static const _fontKey = 'font_scale';

  bool _isDark = false;
  double _fontScale = 1.0; // 0.9 small, 1.0 normal, 1.2 large
  bool _loaded = false;

  bool get isDark => _isDark;
  double get fontScale => _fontScale;
  bool get isLoaded => _loaded;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_darkKey) ?? false;
    _fontScale = prefs.getDouble(_fontKey) ?? 1.0;
    _loaded = true;
    notifyListeners();
  }

  Future<void> toggleDark(bool val) async {
    _isDark = val;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkKey, val);
    notifyListeners();
  }

  Future<void> setFontScale(double scale) async {
    _fontScale = scale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontKey, scale);
    notifyListeners();
  }
}
