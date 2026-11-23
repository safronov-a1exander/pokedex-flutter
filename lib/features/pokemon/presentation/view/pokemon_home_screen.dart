import 'package:flutter/material.dart';
import 'package:pokedex/common/layout/breakpoints.dart';
import 'package:pokedex/features/pokemon/presentation/view/pokemon_list_screen.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Экран по адресу «/».
///
/// В узком окне это список. В широком список уже стоит слева в каркасе, а
/// справа, пока запись не выбрана, подсказка.
class PokemonHomeScreen extends StatelessWidget {
  const PokemonHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Breakpoints.isExpanded(context)) return const PokemonListScreen();
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          AppLocalizations.of(context).selectRecordHint,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
