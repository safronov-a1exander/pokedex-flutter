import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/settings/settings_storage.dart';

/// Какая тема сейчас включена: светлая или тёмная.
///
/// Состояние здесь одно значение ThemeMode, отдельный класс состояния не
/// нужен. Начальное значение берётся из хранилища, каждое переключение туда
/// записывается.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._settings) : super(_settings.themeMode);

  final SettingsStorage _settings;

  void toggle() {
    final next = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(next);
    _settings.setThemeMode(next);
  }
}
