import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/features/pokemon/data/dto/named_resource_dto.dart';

part 'pokemon_species_dto.g.dart';

/// Ответ `GET /pokemon-species/{id}`: вид, описание и ссылка на цепочку
/// эволюции. В `/pokemon/{id}` этого нет, поэтому деталь делает отдельный
/// запрос.
@JsonSerializable()
class PokemonSpeciesDto {
  const PokemonSpeciesDto({
    required this.genera,
    required this.flavorTextEntries,
    required this.evolutionChain,
  });

  factory PokemonSpeciesDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpeciesDtoFromJson(json);

  /// Вид на разных языках.
  final List<GenusDto> genera;

  /// Описания из разных игр на разных языках.
  @JsonKey(name: 'flavor_text_entries')
  final List<FlavorTextDto> flavorTextEntries;

  @JsonKey(name: 'evolution_chain')
  final ResourceDto evolutionChain;
}

@JsonSerializable()
class GenusDto {
  const GenusDto({required this.genus, required this.language});

  factory GenusDto.fromJson(Map<String, dynamic> json) =>
      _$GenusDtoFromJson(json);

  final String genus;
  final NamedResourceDto language;
}

@JsonSerializable()
class FlavorTextDto {
  const FlavorTextDto({required this.flavorText, required this.language});

  factory FlavorTextDto.fromJson(Map<String, dynamic> json) =>
      _$FlavorTextDtoFromJson(json);

  @JsonKey(name: 'flavor_text')
  final String flavorText;
  final NamedResourceDto language;
}

/// Ссылка без имени: `{"url": ".../evolution-chain/1/"}`.
@JsonSerializable()
class ResourceDto {
  const ResourceDto({required this.url});

  factory ResourceDto.fromJson(Map<String, dynamic> json) =>
      _$ResourceDtoFromJson(json);

  final String url;
}
