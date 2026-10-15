import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/features/pokemon/data/dto/named_resource_dto.dart';

part 'pokemon_dto.g.dart';

/// Ответ `GET /pokemon/{id}`.
///
/// DTO повторяет ответ сервера и его имена полей. В ответе около 280 КБ, из
/// них описаны только нужные поля, остальные при разборе пропускаются.
/// Имена в snake_case переводятся через @JsonKey: если сервер переименует
/// поле, правка будет здесь и в маппере, а не в экранах.
@JsonSerializable()
class PokemonDto {
  const PokemonDto({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.types,
    required this.stats,
    required this.abilities,
    required this.sprites,
  });

  factory PokemonDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonDtoFromJson(json);

  final int id;
  final String name;

  /// В дециметрах.
  final int height;

  /// В гектограммах.
  final int weight;

  /// У некоторых записей сервер присылает null.
  @JsonKey(name: 'base_experience')
  final int? baseExperience;

  final List<PokemonTypeSlotDto> types;
  final List<PokemonStatDto> stats;
  final List<PokemonAbilitySlotDto> abilities;
  final PokemonSpritesDto sprites;
}

@JsonSerializable()
class PokemonTypeSlotDto {
  const PokemonTypeSlotDto({required this.type});

  factory PokemonTypeSlotDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeSlotDtoFromJson(json);

  final NamedResourceDto type;
}

@JsonSerializable()
class PokemonStatDto {
  const PokemonStatDto({required this.baseStat, required this.stat});

  factory PokemonStatDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatDtoFromJson(json);

  @JsonKey(name: 'base_stat')
  final int baseStat;
  final NamedResourceDto stat;
}

@JsonSerializable()
class PokemonAbilitySlotDto {
  const PokemonAbilitySlotDto({required this.ability, required this.isHidden});

  factory PokemonAbilitySlotDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilitySlotDtoFromJson(json);

  final NamedResourceDto ability;
  @JsonKey(name: 'is_hidden')
  final bool isHidden;
}

/// Картинки лежат глубоко: `sprites.other["official-artwork"].front_default`.
@JsonSerializable()
class PokemonSpritesDto {
  const PokemonSpritesDto({required this.other});

  factory PokemonSpritesDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesDtoFromJson(json);

  final PokemonOtherSpritesDto? other;
}

@JsonSerializable()
class PokemonOtherSpritesDto {
  const PokemonOtherSpritesDto({required this.officialArtwork});

  factory PokemonOtherSpritesDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonOtherSpritesDtoFromJson(json);

  @JsonKey(name: 'official-artwork')
  final PokemonArtworkDto? officialArtwork;
}

@JsonSerializable()
class PokemonArtworkDto {
  const PokemonArtworkDto({required this.frontDefault});

  factory PokemonArtworkDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonArtworkDtoFromJson(json);

  @JsonKey(name: 'front_default')
  final String? frontDefault;
}
