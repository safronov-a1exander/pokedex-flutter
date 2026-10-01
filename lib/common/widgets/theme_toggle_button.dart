import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/theme/theme_cubit.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Кнопка переключения темы в шапке.
///
/// Сама кнопка ничего не хранит. Какая тема сейчас, она узнаёт из
/// `Theme.of`, а переключает тему [ThemeCubit] из корня приложения.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      onPressed: () => context.read<ThemeCubit>().toggle(),
      // Подсказка тоже подпись. Её же читает экранный диктор.
      tooltip: AppLocalizations.of(context).actionToggleTheme,
      icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
    );
  }
}
