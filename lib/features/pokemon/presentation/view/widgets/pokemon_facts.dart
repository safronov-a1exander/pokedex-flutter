import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/presentation/utils/pokemon_format.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Рост, вес и базовый опыт в строку.
///
/// Числа форматирует ARB: в русском интерфейсе «0,7 м», в английском
/// «0.7 m».
class PokemonFacts extends StatelessWidget {
  const PokemonFacts({super.key, required this.pokemon});

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final style = theme.textTheme.titleSmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 24,
      runSpacing: 4,
      children: [
        Text(l10n.detailHeight(pokemon.heightM), style: style),
        Text(l10n.detailWeight(pokemon.weightKg), style: style),
        Text(l10n.detailBaseXp(pokemon.baseExperience), style: style),
      ],
    );
  }
}
