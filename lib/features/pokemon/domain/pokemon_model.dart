import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';

/// Одна запись каталога: то, что нужно и карточке списка, и детали.
///
/// Данные лежат в том виде, в каком их отдаёт PokéAPI: имя строчными
/// (`bulbasaur`), рост в дециметрах, вес в гектограммах. Как это показать на
/// экране, решают расширения в `presentation/utils`. Импортов Flutter и
/// аннотаций JSON здесь нет: модель не знает ни как её рисуют, ни откуда она
/// пришла.
final class PokemonModel {
  const PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.heightDm,
    required this.weightHg,
    required this.baseExperience,
    required this.abilities,
    required this.stats,
  });

  final int id;
  final String name;

  /// У части записей картинки на сервере нет.
  final String? imageUrl;
  final List<PokemonType> types;
  final int heightDm;
  final int weightHg;

  /// У части записей сервер его не знает.
  final int? baseExperience;
  final List<AbilityModel> abilities;
  final List<StatModel> stats;
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
