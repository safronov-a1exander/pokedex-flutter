import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Настройки приложения, которые переживают перезапуск.
///
/// Обёртка над shared_preferences: ключи и формат значений знает только этот
/// класс. Cubit темы получает его в конструкторе и про shared_preferences не
/// знает.
///
/// Хранилище читается один раз в `main`, до первого кадра. Дальше чтение
/// синхронное, из памяти, поэтому тема не мигает при запуске.
class SettingsStorage {
  SettingsStorage(this._prefs);

  final SharedPreferencesWithCache _prefs;

  static const String _themeModeKey = 'theme_mode';

  /// Все ключи настроек. SharedPreferencesWithCache читает при старте только
  /// их.
  static const Set<String> keys = {_themeModeKey};

  /// Создаётся в `main` до `runApp`: чтение с диска асинхронное.
  static Future<SettingsStorage> create() async {
    final prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(allowList: keys),
    );
    return SettingsStorage(prefs);
  }

  /// Сохранённая тема. Ничего не сохранено или сохранено то, чего мы не
  /// знаем: светлая.
  ThemeMode get themeMode => switch (_prefs.getString(_themeModeKey)) {
    'dark' => ThemeMode.dark,
    _ => ThemeMode.light,
  };

  Future<void> setThemeMode(ThemeMode mode) =>
      _prefs.setString(_themeModeKey, mode.name);
}
