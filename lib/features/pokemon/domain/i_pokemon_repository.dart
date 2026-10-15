import 'package:pokedex/features/pokemon/domain/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Откуда берутся записи каталога.
///
/// Cubit и Bloc знают только этот интерфейс, реализация лежит в data. Все
/// методы при ошибке бросают LoadException из `common/network`.
abstract interface class IPokemonRepository {
  /// Страница списка: [limit] записей, начиная с [offset].
  Future<List<PokemonModel>> getPokemons({
    required int offset,
    required int limit,
  });

  /// Запись со всем, что нужно детали. Нет такой записи: NotFoundException.
  Future<PokemonDetailsModel> getDetails(int id);

  /// Записи, в имени которых есть [query].
  Future<List<PokemonModel>> searchPokemons(String query);
}
