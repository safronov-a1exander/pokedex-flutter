import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/platform/export_result.dart';
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
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<FavoritesCubit, List<PokemonModel>>(
      builder: (context, items) => AppScaffold(
        actions: [
          IconButton(
            // Экспортировать пустой список незачем.
            onPressed: items.isEmpty ? null : () => _export(context),
            tooltip: l10n.actionExportFavorites,
            icon: const Icon(Icons.file_download),
          ),
        ],
        body: items.isEmpty
            ? Center(child: Text(l10n.favoritesEmpty))
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

  /// Результат показываем всегда, и неудачный тоже: молчать нельзя.
  Future<void> _export(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final result = await context.read<FavoritesCubit>().export();
    final message = switch (result) {
      SavedTo(:final path) => l10n.exportSavedTo(path),
      Downloaded() => l10n.exportDownloaded,
      NotSupported() => l10n.exportNotSupported,
      ExportFailed(:final reason) => l10n.exportFailed(reason),
    };
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }
}
