import 'package:flutter/material.dart';
import 'package:pokedex/common/theme/app_colors.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';

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
}
