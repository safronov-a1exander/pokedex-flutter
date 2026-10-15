import 'package:flutter/material.dart';
import 'package:pokedex/common/theme/app_colors.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Как тип выглядит на экране.
extension PokemonTypeFormat on PokemonType {
  /// Цвет типа не зависит от темы, поэтому он берётся из [AppColors], а не
  /// из ColorScheme.
  Color get color => switch (this) {
    PokemonType.normal => AppColors.typeNormal,
    PokemonType.fighting => AppColors.typeFighting,
    PokemonType.flying => AppColors.typeFlying,
    PokemonType.poison => AppColors.typePoison,
    PokemonType.ground => AppColors.typeGround,
    PokemonType.rock => AppColors.typeRock,
    PokemonType.bug => AppColors.typeBug,
    PokemonType.ghost => AppColors.typeGhost,
    PokemonType.steel => AppColors.typeSteel,
    PokemonType.fire => AppColors.typeFire,
    PokemonType.water => AppColors.typeWater,
    PokemonType.grass => AppColors.typeGrass,
    PokemonType.electric => AppColors.typeElectric,
    PokemonType.psychic => AppColors.typePsychic,
    PokemonType.ice => AppColors.typeIce,
    PokemonType.dragon => AppColors.typeDragon,
    PokemonType.dark => AppColors.typeDark,
    PokemonType.fairy => AppColors.typeFairy,
  };

  /// Подпись типа из ARB. В данных тип приходит идентификатором (`grass`),
  /// а на экран идёт перевод, иначе интерфейс останется наполовину
  /// английским. switch по enum без ветки по умолчанию: добавили тип и
  /// забыли подпись, компилятор об этом скажет.
  String label(AppLocalizations l10n) => switch (this) {
    PokemonType.normal => l10n.typeNormal,
    PokemonType.fighting => l10n.typeFighting,
    PokemonType.flying => l10n.typeFlying,
    PokemonType.poison => l10n.typePoison,
    PokemonType.ground => l10n.typeGround,
    PokemonType.rock => l10n.typeRock,
    PokemonType.bug => l10n.typeBug,
    PokemonType.ghost => l10n.typeGhost,
    PokemonType.steel => l10n.typeSteel,
    PokemonType.fire => l10n.typeFire,
    PokemonType.water => l10n.typeWater,
    PokemonType.grass => l10n.typeGrass,
    PokemonType.electric => l10n.typeElectric,
    PokemonType.psychic => l10n.typePsychic,
    PokemonType.ice => l10n.typeIce,
    PokemonType.dragon => l10n.typeDragon,
    PokemonType.dark => l10n.typeDark,
    PokemonType.fairy => l10n.typeFairy,
  };
}
