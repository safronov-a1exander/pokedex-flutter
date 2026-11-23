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
}
