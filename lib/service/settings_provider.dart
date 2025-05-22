import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  // Theme Settings
  bool _isDarkMode = true;
  Color _accentColor = const Color(0xFF1DB954);

  // Playback Settings
  bool _crossfadeEnabled = false;
  double _crossfadeDuration = 0.0;
  final Map<String, double> _equalizerSettings = {
    '60Hz': 0.0,
    '230Hz': 0.0,
    '910Hz': 0.0,
    '3.6kHz': 0.0,
    '14kHz': 0.0,
  };

  // Getters
  bool get isDarkMode => _isDarkMode;
  Color get accentColor => _accentColor;
  bool get crossfadeEnabled => _crossfadeEnabled;
  double get crossfadeDuration => _crossfadeDuration;
  Map<String, double> get equalizerSettings => Map.unmodifiable(_equalizerSettings);

  // Theme Methods
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setAccentColor(Color color) {
    _accentColor = color;
    notifyListeners();
  }

  // Playback Methods
  void toggleCrossfade() {
    _crossfadeEnabled = !_crossfadeEnabled;
    notifyListeners();
  }

  void setCrossfadeDuration(double duration) {
    _crossfadeDuration = duration.clamp(0.0, 12.0);
    notifyListeners();
  }

  void setEqualizerBand(String frequency, double value) {
    if (_equalizerSettings.containsKey(frequency)) {
      _equalizerSettings[frequency] = value.clamp(-12.0, 12.0);
      notifyListeners();
    }
  }

  void resetEqualizer() {
    for (var key in _equalizerSettings.keys) {
      _equalizerSettings[key] = 0.0;
    }
    notifyListeners();
  }

  // Theme Data
  ThemeData get currentTheme {
    if (_isDarkMode) {
      return ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        primaryColor: const Color(0xFF2A2A2A),
        colorScheme: ColorScheme.dark(
          primary: _accentColor,
          secondary: const Color(0xFF404040),
          surface: const Color(0xFF2A2A2A),
          error: const Color(0xFFCF6679),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF2A2A2A),
          elevation: 0,
          iconTheme: IconThemeData(color: _accentColor),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        primaryColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: _accentColor,
          secondary: const Color(0xFFE0E0E0),
          surface: Colors.white,
          error: const Color(0xFFB00020),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: _accentColor),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(color: Colors.black),
        ),
      );
    }
  }
}