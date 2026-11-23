import 'package:pokedex/features/pokemon/data/dto/stored_pokemon_dto.dart';

/// Что приложение хранит у себя на диске: страницы списка для офлайна и
/// избранное.
///
/// Рядом с сетевым датасорсом. Репозиторий решает, откуда брать данные:
/// сеть есть — из сети, и сразу сохраняет сюда; сети нет — отсюда.
abstract interface class ILocalPokemonDataSource {
  /// Сохранённая страница списка. Ничего не сохранено или сохранённое не
  /// читается: null.
  Future<List<StoredPokemonDto>?> getPage({
    required int offset,
    required int limit,
  });

  Future<void> savePage({
    required int offset,
    required int limit,
    required List<StoredPokemonDto> items,
  });

  Future<List<StoredPokemonDto>> getFavorites();

  Future<void> saveFavorites(List<StoredPokemonDto> items);
}
