import 'package:pokedex/features/pokemon/data/dto/evolution_chain_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_page_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_species_dto.dart';

/// Откуда репозиторий берёт данные.
///
/// Сейчас реализация одна, сетевая. Позже рядом появится вторая, с кэшем на
/// диске, и репозиторий будет выбирать между ними. Все методы при ошибке
/// бросают LoadException.
abstract interface class IPokemonDataSource {
  Future<PokemonPageDto> getPokemonPage({
    required int offset,
    required int limit,
  });

  Future<PokemonDto> getPokemon(String idOrName);

  Future<PokemonSpeciesDto> getSpecies(int id);

  Future<EvolutionChainDto> getEvolutionChain(int id);
}
