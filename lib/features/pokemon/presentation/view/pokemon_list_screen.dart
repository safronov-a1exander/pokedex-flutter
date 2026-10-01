import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/widgets/app_scaffold.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_cubit.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_state.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/pokemon_card.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/search_field.dart';

/// Экран списка. Cubit создан в корне приложения, экран только читает его
/// состояние и вызывает его методы.
class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SearchField(
              onChanged: context.read<PokemonListCubit>().search,
            ),
          ),
          // Expanded обязателен: в Column без него ListView получает
          // бесконечную высоту и падает с ошибкой unbounded height.
          Expanded(
            child: BlocBuilder<PokemonListCubit, PokemonListState>(
              // ListView.separated строит карточки по мере прокрутки, а не
              // все сразу.
              builder: (context, state) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) =>
                    PokemonCard(pokemon: state.items[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
