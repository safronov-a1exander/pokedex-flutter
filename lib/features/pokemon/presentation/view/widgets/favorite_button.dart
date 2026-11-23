import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/favorites/favorites_cubit.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Звезда в шапке детали: добавить запись в избранное или убрать.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.pokemon});

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // watch: кнопка перерисуется, когда изменится избранное.
    final selected = context.watch<FavoritesCubit>().contains(pokemon.id);
    return IconButton(
      onPressed: () => context.read<FavoritesCubit>().toggle(pokemon),
      tooltip: selected ? l10n.actionRemoveFavorite : l10n.actionAddFavorite,
      icon: Icon(selected ? Icons.star : Icons.star_border),
    );
  }
}
