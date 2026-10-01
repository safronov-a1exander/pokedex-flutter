import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/common/navigation/app_router.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/presentation/utils/pokemon_format.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/pokemon_image.dart';

/// Вся цепочка эволюции. Это связанные записи на экране детали.
class EvolutionRow extends StatelessWidget {
  const EvolutionRow({
    super.key,
    required this.stages,
    required this.currentId,
  });

  final List<PokemonModel> stages;

  /// Номер открытой записи. Её этап подсвечен и не нажимается.
  final int currentId;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final stage in stages)
          _EvolutionStage(pokemon: stage, current: stage.id == currentId),
      ],
    );
  }
}

class _EvolutionStage extends StatelessWidget {
  const _EvolutionStage({required this.pokemon, required this.current});

  final PokemonModel pokemon;
  final bool current;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      // push, а не go: соседняя запись ложится поверх текущей, и «назад»
      // вернёт к ней. go заменил бы весь стек тем, что записано в адресе.
      onTap: current ? null : () => context.push(AppRoutes.detail(pokemon.id)),
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 96,
        child: Column(
          children: [
            PokemonImage(
              pokemon: pokemon,
              size: 72,
              spriteSize: 56,
              backgroundAlpha: current ? 0.30 : 0.12,
            ),
            const SizedBox(height: 6),
            Text(
              pokemon.displayName,
              style: theme.textTheme.labelMedium?.copyWith(
                color: current
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
