import 'package:json_annotation/json_annotation.dart';

part 'named_resource_dto.g.dart';

/// Ссылка на другую запись API: `{"name": "grass", "url": ".../type/12/"}`.
/// В ответах PokéAPI так устроены почти все связи.
@JsonSerializable()
class NamedResourceDto {
  const NamedResourceDto({required this.name, required this.url});

  factory NamedResourceDto.fromJson(Map<String, dynamic> json) =>
      _$NamedResourceDtoFromJson(json);

  final String name;
  final String url;
}
