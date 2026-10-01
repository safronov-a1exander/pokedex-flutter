import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/widgets/app_scaffold.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_cubit.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_state.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/pokemon_card.dart';

/// Экран списка. Cubit создан в корне приложения, экран только читает его
/// состояние.
class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
        // ListView.separated строит карточки по мере прокрутки, а не все
        // сразу.
        builder: (context, state) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: state.items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              PokemonCard(pokemon: state.items[index]),
        ),
      ),
    );
  }
}
