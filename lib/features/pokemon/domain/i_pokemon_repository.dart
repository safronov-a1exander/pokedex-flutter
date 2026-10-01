import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Откуда берутся записи каталога.
///
/// Cubit и Bloc знают только этот интерфейс, реализация лежит в data. Методы
/// возвращают Future, хотя моки отвечают сразу: когда на их место встанет
/// сеть, интерфейс и все, кто его вызывает, не изменятся.
abstract interface class IPokemonRepository {
  Future<List<PokemonModel>> getPokemons();

  /// null, если записи с таким номером нет. В вебе номер приходит из адресной
  /// строки, а туда можно ввести что угодно.
  Future<PokemonModel?> getPokemon(int id);

  /// Записи, в имени которых есть [query]. Пустой запрос значит «все записи».
  Future<List<PokemonModel>> searchPokemons(String query);
}
