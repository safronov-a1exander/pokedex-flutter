import 'package:flutter/material.dart';
import 'package:pokedex/common/theme/app_colors.dart';

/// Светлая и тёмная тема приложения.
///
/// Вся палитра строится из одного цвета [AppColors.seed]: поверхности, текст,
/// акценты и пары «фон и текст на нём». Виджеты берут цвета через
/// `Theme.of(context).colorScheme`, иначе переключение темы их не заденет.
abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: brightness,
    ),
    // Шрифт лежит в assets/fonts: одинаковый на всех ОС и без сети.
    fontFamily: 'Roboto',
  );
}
