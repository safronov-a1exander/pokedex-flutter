import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Откуда берутся записи каталога.
///
/// Cubit и Bloc знают только этот интерфейс, реализация лежит в data. Методы
/// возвращают Future, хотя моки отвечают сразу: когда на их место встанет
/// сеть, интерфейс и все, кто его вызывает, не изменятся.
abstract interface class IPokemonRepository {
  Future<List<PokemonModel>> getPokemons();
}
