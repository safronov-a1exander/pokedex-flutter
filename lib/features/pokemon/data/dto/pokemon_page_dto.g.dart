// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_page_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonPageDto _$PokemonPageDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PokemonPageDto', json, ($checkedConvert) {
      final val = PokemonPageDto(
        count: $checkedConvert('count', (v) => (v as num).toInt()),
        results: $checkedConvert(
          'results',
          (v) => (v as List<dynamic>)
              .map((e) => NamedResourceDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });
