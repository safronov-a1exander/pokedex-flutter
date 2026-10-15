import 'package:pokedex/features/pokemon/data/dto/evolution_chain_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_species_dto.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';

/// Перевод ответа сервера в модель приложения. Имена полей API известны
/// только DTO и этому файлу.
extension PokemonDtoMapper on PokemonDto {
  PokemonModel toModel() => PokemonModel(
    id: id,
    name: name,
    imageUrl: sprites.other?.officialArtwork?.frontDefault,
    types: [
      for (final slot in types)
        // Тип, которого нет в перечислении, пропускаем, а не падаем.
        ?_typesByName[slot.type.name],
    ],
    heightDm: height,
    weightHg: weight,
    baseExperience: baseExperience,
    abilities: [
      for (final slot in abilities)
        AbilityModel(slot.ability.name, hidden: slot.isHidden),
    ],
    stats: [for (final stat in stats) StatModel(stat.stat.name, stat.baseStat)],
  );
}

final Map<String, PokemonType> _typesByName = PokemonType.values.asNameMap();

extension PokemonSpeciesDtoMapper on PokemonSpeciesDto {
  /// Вид на английском: русского в PokéAPI нет.
  String get englishGenus =>
      genera
          .where((entry) => entry.language.name == _english)
          .map((entry) => entry.genus)
          .firstOrNull ??
      '';

  /// Описание из самой новой игры. В тексте сервера переносы строк и символ
  /// перевода страницы, они заменяются пробелами.
  String get englishFlavorText {
    final text = flavorTextEntries
        .where((entry) => entry.language.name == _english)
        .map((entry) => entry.flavorText)
        .lastOrNull;
    return text?.replaceAll(RegExp(r'\s+'), ' ') ?? '';
  }

  int get evolutionChainId => idFromUrl(evolutionChain.url);
}

extension EvolutionChainDtoMapper on EvolutionChainDto {
  /// Номера всех записей цепочки. Сервер присылает дерево, экрану нужен
  /// плоский список по порядку.
  List<int> get speciesIds {
    final ids = <int>[];
    void visit(ChainLinkDto link) {
      ids.add(idFromUrl(link.species.url));
      link.evolvesTo.forEach(visit);
    }

    visit(chain);
    return ids;
  }
}

const String _english = 'en';

/// Номер записи из ссылки: `.../pokemon-species/2/` → 2.
int idFromUrl(String url) => int.parse(
  Uri.parse(url).pathSegments.lastWhere((segment) => segment.isNotEmpty),
);
