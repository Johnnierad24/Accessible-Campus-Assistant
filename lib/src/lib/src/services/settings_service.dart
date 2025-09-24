import 'package:flutter/material.dart';


class SettingsService extends ChangeNotifier {
bool _isDark = false;
double _fontScale = 1.0; // 0.9 small, 1.0 normal, 1.2 large


bool get isDark => _isDark;
double get fontScale => _fontScale;


void toggleDark(bool val) {
_isDark = val;
notifyListeners();
}


void setFontScale(double scale) {
_fontScale = scale;
notifyListeners();
}
}
