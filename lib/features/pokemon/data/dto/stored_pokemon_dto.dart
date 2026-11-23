import 'package:json_annotation/json_annotation.dart';

part 'stored_pokemon_dto.g.dart';

/// Запись в том виде, в каком она лежит в локальном хранилище.
///
/// Это не ответ сервера, а наш собственный формат: в нём ровно поля модели,
/// без вложенности PokéAPI. Сервер может поменять ответ, а сохранённое у
/// пользователя останется читаемым.
///
/// Запись хранится целиком, а не только номер: без сети приложение должно
/// показать название и типы, а взять их больше неоткуда.
@JsonSerializable(createToJson: true, explicitToJson: true)
class StoredPokemonDto {
  const StoredPokemonDto({
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

  factory StoredPokemonDto.fromJson(Map<String, dynamic> json) =>
      _$StoredPokemonDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StoredPokemonDtoToJson(this);

  final int id;
  final String name;
  final String? imageUrl;

  /// Имена типов: `grass`, `poison`.
  final List<String> types;
  final int heightDm;
  final int weightHg;
  final int? baseExperience;
  final List<StoredAbilityDto> abilities;
  final List<StoredStatDto> stats;
}

@JsonSerializable(createToJson: true)
class StoredAbilityDto {
  const StoredAbilityDto({required this.name, required this.hidden});

  factory StoredAbilityDto.fromJson(Map<String, dynamic> json) =>
      _$StoredAbilityDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StoredAbilityDtoToJson(this);

  final String name;
  final bool hidden;
}

@JsonSerializable(createToJson: true)
class StoredStatDto {
  const StoredStatDto({required this.key, required this.value});

  factory StoredStatDto.fromJson(Map<String, dynamic> json) =>
      _$StoredStatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StoredStatDtoToJson(this);

  final String key;
  final int value;
}
