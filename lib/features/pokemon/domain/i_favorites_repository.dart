import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Избранное. Хранится на устройстве и открывается без сети.
abstract interface class IFavoritesRepository {
  Future<List<PokemonModel>> getAll();

  /// Сохраняет избранное целиком: хранилище «ключ → строка» пишет всё сразу.
  Future<void> saveAll(List<PokemonModel> items);
}
