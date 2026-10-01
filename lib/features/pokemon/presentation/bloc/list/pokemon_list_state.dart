import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Состояние экрана списка: всё, что нужно нарисовать, одним объектом.
///
/// Класс неизменяемый. Новое состояние создаётся через [copyWith], поля
/// старого не меняются. Cubit не отправит экрану тот же самый объект второй
/// раз, поэтому правка полей на месте до экрана не дойдёт.
final class PokemonListState {
  const PokemonListState({this.items = const []});

  final List<PokemonModel> items;

  PokemonListState copyWith({List<PokemonModel>? items}) =>
      PokemonListState(items: items ?? this.items);
}
