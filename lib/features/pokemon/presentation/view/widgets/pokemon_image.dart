import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/presentation/utils/pokemon_format.dart';

/// Картинка записи на круглой подложке цвета типа.
///
/// Размеры задаются снаружи: один виджет нужен и карточке, и детали, и этапу
/// эволюции.
class PokemonImage extends StatelessWidget {
  const PokemonImage({
    super.key,
    required this.pokemon,
    required this.size,
    required this.spriteSize,
    this.backgroundAlpha = 0.16,
  });

  final PokemonModel pokemon;
  final double size;
  final double spriteSize;

  /// Насколько плотная подложка: 0 — прозрачная, 1 — цвет типа целиком.
  final double backgroundAlpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: pokemon.accent.withValues(alpha: backgroundAlpha),
        shape: BoxShape.circle,
      ),
      child: Image.asset(pokemon.sprite, width: spriteSize, height: spriteSize),
    );
  }
}
