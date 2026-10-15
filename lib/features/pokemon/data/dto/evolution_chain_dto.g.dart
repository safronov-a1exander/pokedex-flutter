// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evolution_chain_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EvolutionChainDto _$EvolutionChainDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EvolutionChainDto', json, ($checkedConvert) {
      final val = EvolutionChainDto(
        chain: $checkedConvert(
          'chain',
          (v) => ChainLinkDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

ChainLinkDto _$ChainLinkDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ChainLinkDto', json, ($checkedConvert) {
      final val = ChainLinkDto(
        species: $checkedConvert(
          'species',
          (v) => NamedResourceDto.fromJson(v as Map<String, dynamic>),
        ),
        evolvesTo: $checkedConvert(
          'evolves_to',
          (v) => (v as List<dynamic>)
              .map((e) => ChainLinkDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'evolvesTo': 'evolves_to'});
