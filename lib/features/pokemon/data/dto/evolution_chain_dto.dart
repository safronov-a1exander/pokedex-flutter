import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/features/pokemon/data/dto/named_resource_dto.dart';

part 'evolution_chain_dto.g.dart';

/// Ответ `GET /evolution-chain/{id}`. Цепочка приходит деревом: у каждого
/// звена список тех, в кого оно эволюционирует.
@JsonSerializable()
class EvolutionChainDto {
  const EvolutionChainDto({required this.chain});

  factory EvolutionChainDto.fromJson(Map<String, dynamic> json) =>
      _$EvolutionChainDtoFromJson(json);

  final ChainLinkDto chain;
}

@JsonSerializable()
class ChainLinkDto {
  const ChainLinkDto({required this.species, required this.evolvesTo});

  factory ChainLinkDto.fromJson(Map<String, dynamic> json) =>
      _$ChainLinkDtoFromJson(json);

  final NamedResourceDto species;
  @JsonKey(name: 'evolves_to')
  final List<ChainLinkDto> evolvesTo;
}
