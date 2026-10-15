import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Всё, что показывает экран детали.
///
/// Вид, описание и эволюция лежат на сервере в других адресах, чем сама
/// запись. Карточке списка они не нужны, поэтому живут отдельно от
/// [PokemonModel] и загружаются только для детали.
final class PokemonDetailsModel {
  const PokemonDetailsModel({
    required this.pokemon,
    required this.genus,
    required this.flavorText,
    required this.evolution,
  });

  final PokemonModel pokemon;

  /// Вид, например «Seed Pokémon». В API есть только на английском.
  final String genus;
  final String flavorText;

  /// Вся цепочка эволюции по порядку, включая саму запись.
  final List<PokemonModel> evolution;
}
