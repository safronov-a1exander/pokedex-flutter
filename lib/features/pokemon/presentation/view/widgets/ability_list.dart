import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/presentation/utils/pokemon_format.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Способности столбиком. Скрытая помечена подписью из ARB.
class AbilityList extends StatelessWidget {
  const AbilityList({super.key, required this.abilities});

  final List<AbilityModel> abilities;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        for (final ability in abilities)
          Text(
            ability.hidden
                ? l10n.abilityHidden(ability.displayName)
                : ability.displayName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }
}
