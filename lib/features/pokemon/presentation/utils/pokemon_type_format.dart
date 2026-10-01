import 'package:flutter/material.dart';
import 'package:pokedex/common/theme/app_colors.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Как тип выглядит на экране.
extension PokemonTypeFormat on PokemonType {
  /// Цвет типа не зависит от темы, поэтому он берётся из [AppColors], а не
  /// из ColorScheme.
  Color get color => switch (this) {
    PokemonType.bug => AppColors.typeBug,
    PokemonType.fire => AppColors.typeFire,
    PokemonType.flying => AppColors.typeFlying,
    PokemonType.grass => AppColors.typeGrass,
    PokemonType.normal => AppColors.typeNormal,
    PokemonType.poison => AppColors.typePoison,
    PokemonType.water => AppColors.typeWater,
  };

  /// Подпись типа из ARB. В данных тип приходит идентификатором (`grass`),
  /// а на экран идёт перевод, иначе интерфейс останется наполовину
  /// английским. switch по enum без ветки по умолчанию: добавили тип и
  /// забыли подпись, компилятор об этом скажет.
  String label(AppLocalizations l10n) => switch (this) {
    PokemonType.bug => l10n.typeBug,
    PokemonType.fire => l10n.typeFire,
    PokemonType.flying => l10n.typeFlying,
    PokemonType.grass => l10n.typeGrass,
    PokemonType.normal => l10n.typeNormal,
    PokemonType.poison => l10n.typePoison,
    PokemonType.water => l10n.typeWater,
  };
}
