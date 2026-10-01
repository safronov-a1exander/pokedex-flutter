import 'package:flutter/material.dart';
import 'package:pokedex/common/widgets/theme_toggle_button.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Шапка приложения и место под содержимое экрана. Каждый экран строит свой
/// AppScaffold.
///
/// В [actions] кладут кнопки для правого угла шапки. Переключатель темы
/// AppScaffold добавляет сам, он нужен на всех экранах. Стрелку «назад»
/// рисовать не нужно: AppBar сам покажет её, когда под экраном в стеке есть
/// другой.
class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.body, this.actions = const []});

  final Widget body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
        actions: [...actions, const ThemeToggleButton()],
      ),
      body: body,
    );
  }
}
