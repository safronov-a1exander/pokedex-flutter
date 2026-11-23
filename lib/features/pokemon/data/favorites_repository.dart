import 'package:pokedex/common/platform/file_export.dart';
import 'package:pokedex/features/pokemon/data/data_sources/i_local_pokemon_data_source.dart';
import 'package:pokedex/features/pokemon/data/mappers/stored_pokemon_mapper.dart';
import 'package:pokedex/features/pokemon/domain/i_favorites_repository.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Избранное в локальном хранилище. Сети здесь нет вообще.
final class FavoritesRepository implements IFavoritesRepository {
  const FavoritesRepository(this._local);

  final ILocalPokemonDataSource _local;

  @override
  Future<List<PokemonModel>> getAll() async => [
    for (final item in await _local.getFavorites()) item.toModel(),
  ];

  @override
  Future<void> saveAll(List<PokemonModel> items) =>
      _local.saveFavorites([for (final item in items) item.toStored()]);

  /// CSV: номер, имя, типы. Данные как в API, без перевода: файл читают
  /// таблицы, а не пользователь интерфейса.
  @override
  Future<ExportResult> export(List<PokemonModel> items) {
    final lines = [
      'id,name,types',
      for (final item in items)
        '${item.id},${item.name},${item.types.map((t) => t.name).join(' ')}',
    ];
    return exportTextFile(_fileName, '${lines.join('\n')}\n');
  }

  static const String _fileName = 'pokedex_favorites.csv';
}
