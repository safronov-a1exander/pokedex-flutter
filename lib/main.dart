import 'package:flutter/material.dart';
import 'package:pokedex/app.dart';

/// Язык можно задать при запуске, не меняя настройки браузера и системы:
///   flutter run -d chrome --dart-define=LOCALE=en
/// Без флага язык берётся из системы, в браузере из настроек браузера.
const String _locale = String.fromEnvironment('LOCALE');

void main() {
  runApp(App(locale: _locale.isEmpty ? null : Locale(_locale)));
}
