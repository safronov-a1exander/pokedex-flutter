import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';
import 'package:pokedex/features/pokemon/presentation/utils/pokemon_type_format.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/type_chip.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Бейджи типов в строку. Wrap, а не Row: если бейджи не влезли, они
/// переносятся на следующую строку, а не вылезают за край.
class TypeRow extends StatelessWidget {
  const TypeRow({super.key, required this.types});

  final List<PokemonType> types;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final type in types)
          TypeChip(label: type.label(l10n), color: type.color),
      ],
    );
  }
}
