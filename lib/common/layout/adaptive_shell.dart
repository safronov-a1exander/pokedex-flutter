import 'package:flutter/material.dart';
import 'package:pokedex/common/layout/breakpoints.dart';
import 'package:pokedex/features/pokemon/presentation/view/pokemon_list_screen.dart';

/// Каркас вокруг списка и детали.
///
/// Узкое окно: показывает только текущий экран, список и деталь сменяют друг
/// друга, как раньше. Широкое окно: список всегда слева, справа текущий экран
/// маршрута, то есть деталь или подсказка «выберите запись».
///
/// Список в широком окне живёт здесь, а не в маршруте, поэтому при смене
/// записи он не пересоздаётся и прокрутка остаётся на месте.
class AdaptiveShell extends StatelessWidget {
  const AdaptiveShell({super.key, required this.child});

  /// Экран текущего маршрута внутри каркаса.
  final Widget child;

  static const double _listWidth = 420;

  @override
  Widget build(BuildContext context) {
    if (!Breakpoints.isExpanded(context)) return child;
    return Row(
      children: [
        const SizedBox(width: _listWidth, child: PokemonListScreen()),
        const VerticalDivider(width: 1),
        Expanded(child: child),
      ],
    );
  }
}
