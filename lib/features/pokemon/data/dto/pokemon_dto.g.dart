// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDto _$PokemonDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PokemonDto', json, ($checkedConvert) {
  final val = PokemonDto(
    id: $checkedConvert('id', (v) => (v as num).toInt()),
    name: $checkedConvert('name', (v) => v as String),
    height: $checkedConvert('height', (v) => (v as num).toInt()),
    weight: $checkedConvert('weight', (v) => (v as num).toInt()),
    baseExperience: $checkedConvert(
      'base_experience',
      (v) => (v as num?)?.toInt(),
    ),
    types: $checkedConvert(
      'types',
      (v) => (v as List<dynamic>)
          .map((e) => PokemonTypeSlotDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    stats: $checkedConvert(
      'stats',
      (v) => (v as List<dynamic>)
          .map((e) => PokemonStatDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    abilities: $checkedConvert(
      'abilities',
      (v) => (v as List<dynamic>)
          .map((e) => PokemonAbilitySlotDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    sprites: $checkedConvert(
      'sprites',
      (v) => PokemonSpritesDto.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'baseExperience': 'base_experience'});

PokemonTypeSlotDto _$PokemonTypeSlotDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PokemonTypeSlotDto', json, ($checkedConvert) {
      final val = PokemonTypeSlotDto(
        type: $checkedConvert(
          'type',
          (v) => NamedResourceDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

PokemonStatDto _$PokemonStatDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PokemonStatDto', json, ($checkedConvert) {
      final val = PokemonStatDto(
        baseStat: $checkedConvert('base_stat', (v) => (v as num).toInt()),
        stat: $checkedConvert(
          'stat',
          (v) => NamedResourceDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'baseStat': 'base_stat'});

PokemonAbilitySlotDto _$PokemonAbilitySlotDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PokemonAbilitySlotDto', json, ($checkedConvert) {
  final val = PokemonAbilitySlotDto(
    ability: $checkedConvert(
      'ability',
      (v) => NamedResourceDto.fromJson(v as Map<String, dynamic>),
    ),
    isHidden: $checkedConvert('is_hidden', (v) => v as bool),
  );
  return val;
}, fieldKeyMap: const {'isHidden': 'is_hidden'});

PokemonSpritesDto _$PokemonSpritesDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PokemonSpritesDto', json, ($checkedConvert) {
      final val = PokemonSpritesDto(
        other: $checkedConvert(
          'other',
          (v) => v == null
              ? null
              : PokemonOtherSpritesDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

PokemonOtherSpritesDto _$PokemonOtherSpritesDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PokemonOtherSpritesDto', json, ($checkedConvert) {
  final val = PokemonOtherSpritesDto(
    officialArtwork: $checkedConvert(
      'official-artwork',
      (v) => v == null
          ? null
          : PokemonArtworkDto.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'officialArtwork': 'official-artwork'});

PokemonArtworkDto _$PokemonArtworkDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PokemonArtworkDto', json, ($checkedConvert) {
      final val = PokemonArtworkDto(
        frontDefault: $checkedConvert('front_default', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'frontDefault': 'front_default'});
