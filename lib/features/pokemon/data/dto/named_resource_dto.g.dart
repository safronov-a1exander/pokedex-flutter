// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'named_resource_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NamedResourceDto _$NamedResourceDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NamedResourceDto', json, ($checkedConvert) {
      final val = NamedResourceDto(
        name: $checkedConvert('name', (v) => v as String),
        url: $checkedConvert('url', (v) => v as String),
      );
      return val;
    });
