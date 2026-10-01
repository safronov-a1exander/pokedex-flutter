import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/presentation/utils/pokemon_format.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/card_surface.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/pokemon_image.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/type_row.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Карточка списка: картинка слева, номер, имя и типы справа.
class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return CardSurface(
      child: Row(
        children: [
          PokemonImage(pokemon: pokemon, size: 80, spriteSize: 64),
          const SizedBox(width: 16),
          // Expanded: текстовой колонке достаётся вся оставшаяся ширина.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                Text(
                  l10n.pokemonNumber(pokemon.displayNumber),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(pokemon.displayName, style: theme.textTheme.titleMedium),
                TypeRow(types: pokemon.types),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
