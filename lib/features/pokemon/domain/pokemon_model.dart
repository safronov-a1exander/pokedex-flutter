import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';

/// Одна запись каталога.
///
/// Данные лежат здесь в том виде, в каком их отдаёт PokéAPI: имя строчными
/// (`bulbasaur`), рост в дециметрах, вес в гектограммах. Как это показать на
/// экране, решают расширения в `presentation/utils`. Импортов Flutter здесь
/// нет: модель не знает, чем её рисуют.
final class PokemonModel {
  const PokemonModel({
    required this.id,
    required this.name,
    required this.genus,
    required this.types,
    required this.heightDm,
    required this.weightHg,
    required this.baseExperience,
    required this.abilities,
    required this.stats,
    required this.evolutionChain,
    required this.flavorText,
  });

  final int id;
  final String name;

  /// Вид, например «Seed Pokémon». В API есть только на английском.
  final String genus;
  final List<PokemonType> types;
  final int heightDm;
  final int weightHg;
  final int baseExperience;
  final List<AbilityModel> abilities;
  final List<StatModel> stats;

  /// Номера всей цепочки эволюции, включая саму запись. У bulbasaur это 1, 2, 3.
  final List<int> evolutionChain;
  final String flavorText;
}

/// Способность. Скрытая способность в игре встречается редко, поэтому она
/// помечена отдельно.
final class AbilityModel {
  const AbilityModel(this.name, {required this.hidden});

  final String name;
  final bool hidden;
}

/// Базовая характеристика. [key] — идентификатор из API (`special-attack`),
/// подпись к нему берётся из ARB.
final class StatModel {
  const StatModel(this.key, this.value);

  final String key;
  final int value;
}
