import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/l10n/app_localizations.dart';

extension StatFormat on StatModel {
  /// Подпись характеристики из ARB. В API характеристик шесть. Незнакомый
  /// ключ показывается как есть, чтобы новая характеристика не уронила экран.
  String label(AppLocalizations l10n) => switch (key) {
    'hp' => l10n.statHp,
    'attack' => l10n.statAttack,
    'defense' => l10n.statDefense,
    'special-attack' => l10n.statSpecialAttack,
    'special-defense' => l10n.statSpecialDefense,
    'speed' => l10n.statSpeed,
    _ => key,
  };
}
