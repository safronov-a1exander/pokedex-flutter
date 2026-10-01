import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/widgets/app_scaffold.dart';
import 'package:pokedex/features/pokemon/domain/i_pokemon_repository.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/detail/pokemon_detail_bloc.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/detail/pokemon_detail_event.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/detail/pokemon_detail_state.dart';
import 'package:pokedex/features/pokemon/presentation/utils/pokemon_format.dart';
import 'package:pokedex/features/pokemon/presentation/utils/stat_format.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/ability_list.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/evolution_row.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/pokemon_facts.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/pokemon_image.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/section.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/stat_bar.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/type_row.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Экран одной записи.
class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    // У каждой открытой записи свой Bloc. Он создаётся вместе с экраном и
    // закрывается, когда экран снимают со стека.
    return BlocProvider(
      create: (context) =>
          PokemonDetailBloc(context.read<IPokemonRepository>())
            ..add(PokemonDetailOpened(id)),
      child: AppScaffold(
        body: BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
          // switch по sealed-состоянию: забыть вариант не даст компилятор.
          builder: (context, state) => switch (state) {
            PokemonDetailLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            PokemonDetailNotFound(:final id) => Center(
              child: Text(AppLocalizations.of(context).detailNotFound(id)),
            ),
            PokemonDetailLoaded(:final pokemon, :final evolution) =>
              _DetailContent(pokemon: pokemon, evolution: evolution),
          },
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.pokemon, required this.evolution});

  final PokemonModel pokemon;
  final List<PokemonModel> evolution;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        // В широком окне браузера деталь не растягивается во всю ширину.
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            spacing: 12,
            children: [
              PokemonImage(pokemon: pokemon, size: 200, spriteSize: 164),
              Text(
                l10n.pokemonNumber(pokemon.displayNumber),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(pokemon.displayName, style: theme.textTheme.headlineMedium),
              Text(
                pokemon.genus,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              TypeRow(types: pokemon.types),
              PokemonFacts(pokemon: pokemon),
              Text(
                pokemon.flavorText,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              Section(title: l10n.sectionStats),
              for (final stat in pokemon.stats)
                StatBar(
                  label: stat.label(l10n),
                  value: stat.value,
                  color: pokemon.accent,
                ),
              Section(title: l10n.sectionAbilities),
              AbilityList(abilities: pokemon.abilities),
              Section(title: l10n.sectionEvolution),
              EvolutionRow(stages: evolution, currentId: pokemon.id),
            ],
          ),
        ),
      ),
    );
  }
}
