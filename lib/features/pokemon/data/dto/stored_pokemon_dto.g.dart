// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_pokemon_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoredPokemonDto _$StoredPokemonDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StoredPokemonDto', json, ($checkedConvert) {
      final val = StoredPokemonDto(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        name: $checkedConvert('name', (v) => v as String),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String?),
        types: $checkedConvert(
          'types',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        heightDm: $checkedConvert('heightDm', (v) => (v as num).toInt()),
        weightHg: $checkedConvert('weightHg', (v) => (v as num).toInt()),
        baseExperience: $checkedConvert(
          'baseExperience',
          (v) => (v as num?)?.toInt(),
        ),
        abilities: $checkedConvert(
          'abilities',
          (v) => (v as List<dynamic>)
              .map((e) => StoredAbilityDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        stats: $checkedConvert(
          'stats',
          (v) => (v as List<dynamic>)
              .map((e) => StoredStatDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StoredPokemonDtoToJson(StoredPokemonDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'types': instance.types,
      'heightDm': instance.heightDm,
      'weightHg': instance.weightHg,
      'baseExperience': instance.baseExperience,
      'abilities': instance.abilities.map((e) => e.toJson()).toList(),
      'stats': instance.stats.map((e) => e.toJson()).toList(),
    };

StoredAbilityDto _$StoredAbilityDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StoredAbilityDto', json, ($checkedConvert) {
      final val = StoredAbilityDto(
        name: $checkedConvert('name', (v) => v as String),
        hidden: $checkedConvert('hidden', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$StoredAbilityDtoToJson(StoredAbilityDto instance) =>
    <String, dynamic>{'name': instance.name, 'hidden': instance.hidden};

StoredStatDto _$StoredStatDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StoredStatDto', json, ($checkedConvert) {
      final val = StoredStatDto(
        key: $checkedConvert('key', (v) => v as String),
        value: $checkedConvert('value', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$StoredStatDtoToJson(StoredStatDto instance) =>
    <String, dynamic>{'key': instance.key, 'value': instance.value};
