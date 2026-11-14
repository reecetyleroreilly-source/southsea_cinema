import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefTextScale = 'text_scale';
const String prefThemeMode = 'theme_mode';
const double defaultTextScale = 1.0;
const double minTextScale = 0.8;
const double maxTextScale = 1.5;
const ThemeMode defaultThemeMode = ThemeMode.dark;

class FontSizeSettings extends ChangeNotifier {
  double _textScale = defaultTextScale;
  ThemeMode _themeMode = defaultThemeMode;

  double get textScale => _textScale;
  ThemeMode get themeMode => _themeMode;

  Future<void> load() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final double? savedScale = await prefs.getDouble(prefTextScale);
    final String? savedThemeMode = await prefs.getString(prefThemeMode);
    bool hasUpdatedSettings = false;

    if (savedScale != null &&
        savedScale >= minTextScale &&
        savedScale <= maxTextScale) {
      _textScale = savedScale;
      hasUpdatedSettings = true;
    }

    if (savedThemeMode == ThemeMode.light.name) {
      _themeMode = ThemeMode.light;
      hasUpdatedSettings = true;
    } else if (savedThemeMode == ThemeMode.dark.name) {
      _themeMode = ThemeMode.dark;
      hasUpdatedSettings = true;
    }

    if (hasUpdatedSettings) {
      notifyListeners();
    }
  }

  Future<void> setTextScale(double value) async {
    final double clampedValue =
        value.clamp(minTextScale, maxTextScale).toDouble();
    _textScale = clampedValue;
    notifyListeners();

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    await prefs.setDouble(prefTextScale, clampedValue);
  }

  Future<void> setThemeMode(ThemeMode value) async {
    _themeMode = value;
    notifyListeners();

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    await prefs.setString(prefThemeMode, value.name);
  }
}

class FontSizeSettingsScope extends InheritedNotifier<FontSizeSettings> {
  const FontSizeSettingsScope({
    super.key,
    required FontSizeSettings settings,
    required super.child,
  }) : super(notifier: settings);

  static FontSizeSettings? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FontSizeSettingsScope>()
        ?.notifier;
  }

  static FontSizeSettings of(BuildContext context) {
    final FontSizeSettings? settings = maybeOf(context);
    assert(
      settings != null,
      'FontSizeSettingsScope is missing from the widget tree',
    );
    return settings!;
  }
}
