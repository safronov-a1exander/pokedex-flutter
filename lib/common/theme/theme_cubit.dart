import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Какая тема сейчас включена: светлая или тёмная.
///
/// Состояние здесь одно значение ThemeMode, отдельный класс состояния не
/// нужен.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggle() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}
