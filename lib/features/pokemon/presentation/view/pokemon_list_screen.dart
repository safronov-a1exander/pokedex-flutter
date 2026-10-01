import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/widgets/app_scaffold.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_cubit.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_state.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Экран списка. Пока на нём только число записей в состоянии.
class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      // BlocBuilder пересобирает своё поддерево на каждое новое состояние.
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
        builder: (context, state) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              AppLocalizations.of(context).startHint(state.items.length),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
