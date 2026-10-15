import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/features/pokemon/data/dto/named_resource_dto.dart';

part 'pokemon_page_dto.g.dart';

/// Ответ `GET /pokemon?offset=0&limit=20`: страница списка.
///
/// В странице только имена и ссылки. Типов и картинок в ней нет.
@JsonSerializable()
class PokemonPageDto {
  const PokemonPageDto({required this.count, required this.results});

  factory PokemonPageDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonPageDtoFromJson(json);

  /// Сколько записей всего на сервере.
  final int count;
  final List<NamedResourceDto> results;
}
