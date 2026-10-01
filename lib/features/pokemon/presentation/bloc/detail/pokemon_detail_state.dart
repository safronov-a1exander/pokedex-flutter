import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Состояние экрана детали.
///
/// Класс sealed: switch по состоянию обязан разобрать все варианты, иначе код
/// не скомпилируется.
sealed class PokemonDetailState {
  const PokemonDetailState();
}

final class PokemonDetailLoading extends PokemonDetailState {
  const PokemonDetailLoading();
}

final class PokemonDetailLoaded extends PokemonDetailState {
  const PokemonDetailLoaded(this.pokemon, {required this.evolution});

  final PokemonModel pokemon;

  /// Вся цепочка эволюции по порядку, включая саму запись.
  final List<PokemonModel> evolution;
}

/// Записи с таким номером нет. В вебе адрес /pokemon/999 можно ввести руками,
/// и для него нужен свой экран.
final class PokemonDetailNotFound extends PokemonDetailState {
  const PokemonDetailNotFound(this.id);

  final int id;
}
