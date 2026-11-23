import 'dart:convert';

import 'package:pokedex/features/pokemon/data/data_sources/i_local_pokemon_data_source.dart';
import 'package:pokedex/features/pokemon/data/dto/stored_pokemon_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Локальные данные в shared_preferences.
///
/// Хранилище «ключ → строка», поэтому список записей лежит под одним ключом
/// одной JSON-строкой: читаем целиком и пишем целиком. В браузере это
/// localStorage, его видно в F12 → Application → Local Storage.
final class LocalPokemonDataSource implements ILocalPokemonDataSource {
  LocalPokemonDataSource(this._prefs);

  final SharedPreferencesAsync _prefs;

  static const String _favoritesKey = 'favorites';

  static String _pageKey(int offset, int limit) => 'page_${offset}_$limit';

  @override
  Future<List<StoredPokemonDto>?> getPage({
    required int offset,
    required int limit,
  }) => _readList(_pageKey(offset, limit));

  @override
  Future<void> savePage({
    required int offset,
    required int limit,
    required List<StoredPokemonDto> items,
  }) => _writeList(_pageKey(offset, limit), items);

  @override
  Future<List<StoredPokemonDto>> getFavorites() async =>
      await _readList(_favoritesKey) ?? [];

  @override
  Future<void> saveFavorites(List<StoredPokemonDto> items) =>
      _writeList(_favoritesKey, items);

  Future<List<StoredPokemonDto>?> _readList(String key) async {
    final json = await _prefs.getString(key);
    if (json == null) return null;
    try {
      final list = jsonDecode(json) as List<dynamic>;
      return [
        for (final item in list)
          StoredPokemonDto.fromJson(item as Map<String, dynamic>),
      ];
    } on Object {
      // Старая версия приложения могла записать другой формат. Такой кэш
      // считаем пустым, а не падаем при запуске.
      return null;
    }
  }

  Future<void> _writeList(String key, List<StoredPokemonDto> items) => _prefs
      .setString(key, jsonEncode([for (final item in items) item.toJson()]));
}
