import 'package:flutter/material.dart';
import 'package:pokedex/app.dart';
import 'package:pokedex/common/settings/settings_storage.dart';

/// Язык можно задать при запуске, не меняя настройки браузера и системы:
///   flutter run -d chrome --dart-define=LOCALE=en
/// Без флага язык берётся из системы, в браузере из настроек браузера.
const String _locale = String.fromEnvironment('LOCALE');

Future<void> main() async {
  // Хранилище — плагин. До runApp Flutter ещё не готов говорить с
  // платформой, эта строка его готовит.
  WidgetsFlutterBinding.ensureInitialized();
  // Настройки читаем до первого кадра. Иначе он нарисуется со светлой темой,
  // а через мгновение переключится на сохранённую тёмную.
  final settings = await SettingsStorage.create();
  runApp(
    App(settings: settings, locale: _locale.isEmpty ? null : Locale(_locale)),
  );
}
