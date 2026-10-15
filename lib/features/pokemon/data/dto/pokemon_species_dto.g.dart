// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_species_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonSpeciesDto _$PokemonSpeciesDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PokemonSpeciesDto',
      json,
      ($checkedConvert) {
        final val = PokemonSpeciesDto(
          genera: $checkedConvert(
            'genera',
            (v) => (v as List<dynamic>)
                .map((e) => GenusDto.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          flavorTextEntries: $checkedConvert(
            'flavor_text_entries',
            (v) => (v as List<dynamic>)
                .map((e) => FlavorTextDto.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          evolutionChain: $checkedConvert(
            'evolution_chain',
            (v) => ResourceDto.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'flavorTextEntries': 'flavor_text_entries',
        'evolutionChain': 'evolution_chain',
      },
    );

GenusDto _$GenusDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GenusDto', json, ($checkedConvert) {
      final val = GenusDto(
        genus: $checkedConvert('genus', (v) => v as String),
        language: $checkedConvert(
          'language',
          (v) => NamedResourceDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

FlavorTextDto _$FlavorTextDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FlavorTextDto', json, ($checkedConvert) {
      final val = FlavorTextDto(
        flavorText: $checkedConvert('flavor_text', (v) => v as String),
        language: $checkedConvert(
          'language',
          (v) => NamedResourceDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'flavorText': 'flavor_text'});

ResourceDto _$ResourceDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ResourceDto', json, ($checkedConvert) {
      final val = ResourceDto(url: $checkedConvert('url', (v) => v as String));
      return val;
    });
