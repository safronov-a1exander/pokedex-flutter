import 'package:pokedex/features/pokemon/data/mock_pokemons.dart';
import 'package:pokedex/features/pokemon/domain/i_pokemon_repository.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Репозиторий на моках: отдаёт записи сразу, без сети.
///
/// Когда появится сеть, поменяется только этот класс.
final class PokemonRepository implements IPokemonRepository {
  const PokemonRepository();

  @override
  Future<List<PokemonModel>> getPokemons() async => mockPokemons;
}
