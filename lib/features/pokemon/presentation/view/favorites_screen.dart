import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/widgets/app_scaffold.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/favorites/favorites_cubit.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/pokemon_card.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Экран избранного. Записи берутся из хранилища, сеть не нужна.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocBuilder<FavoritesCubit, List<PokemonModel>>(
        builder: (context, items) => items.isEmpty
            ? Center(child: Text(AppLocalizations.of(context).favoritesEmpty))
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) =>
                    PokemonCard(pokemon: items[index]),
              ),
      ),
    );
  }
}
