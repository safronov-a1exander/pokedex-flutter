import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Страница списка и то, откуда она взялась.
final class PokemonPageModel {
  const PokemonPageModel({required this.items, required this.fromCache});

  final List<PokemonModel> items;

  /// Сети не было, страница прочитана из локального хранилища. Экран
  /// показывает над списком плашку об этом.
  final bool fromCache;
}
