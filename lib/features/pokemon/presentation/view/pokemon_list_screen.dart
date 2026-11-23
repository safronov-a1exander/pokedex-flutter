import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/common/navigation/app_router.dart';
import 'package:pokedex/common/widgets/app_scaffold.dart';
import 'package:pokedex/common/widgets/load_error_view.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_cubit.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_state.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/cache_banner.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/pokemon_card.dart';
import 'package:pokedex/features/pokemon/presentation/view/widgets/search_field.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Экран списка. Cubit создан в корне приложения, экран только читает его
/// состояние и вызывает его методы.
class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PokemonListCubit>();
    return AppScaffold(
      actions: [
        IconButton(
          onPressed: () => context.push(AppRoutes.favorites),
          tooltip: AppLocalizations.of(context).actionOpenFavorites,
          icon: const Icon(Icons.star),
        ),
      ],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SearchField(onChanged: cubit.search),
          ),
          // Плашка видна, только когда список прочитан из хранилища.
          BlocSelector<PokemonListCubit, PokemonListState, bool>(
            selector: (state) => state is PokemonListLoaded && state.fromCache,
            builder: (context, fromCache) =>
                fromCache ? const CacheBanner() : const SizedBox.shrink(),
          ),
          // Expanded обязателен: в Column без него ListView получает
          // бесконечную высоту и падает с ошибкой unbounded height.
          Expanded(
            child: BlocBuilder<PokemonListCubit, PokemonListState>(
              // switch по sealed-состоянию: забыть вариант не даст компилятор.
              builder: (context, state) => switch (state) {
                PokemonListLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                PokemonListFailure(:final error) => Center(
                  child: LoadErrorView(error: error, onRetry: cubit.retry),
                ),
                PokemonListLoaded(:final items) when items.isEmpty => Center(
                  child: Text(AppLocalizations.of(context).searchNothingFound),
                ),
                PokemonListLoaded() => _PokemonList(state: state),
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Список с подгрузкой страниц. Виджет с состоянием, потому что ему нужен
/// ScrollController: по нему видно, что список докручен почти до конца.
class _PokemonList extends StatefulWidget {
  const _PokemonList({required this.state});

  final PokemonListLoaded state;

  @override
  State<_PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<_PokemonList> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// До конца осталось меньше двух карточек: просим следующую страницу.
  /// Вызовов будет много, лишние отсекает Cubit.
  void _onScroll() {
    if (_controller.position.extentAfter < 240) {
      context.read<PokemonListCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final showFooter = state.isLoadingMore || state.loadMoreError != null;
    // ListView.separated строит карточки по мере прокрутки, а не все сразу.
    return ListView.separated(
      controller: _controller,
      padding: const EdgeInsets.all(16),
      itemCount: state.items.length + (showFooter ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) => index < state.items.length
          ? PokemonCard(
              pokemon: state.items[index],
              // go, а не push: в широком окне новая запись заменяет
              // открытую справа, а не ложится поверх неё. В узком под
              // деталью всё равно окажется список: маршрут вложенный.
              onTap: () => context.go(AppRoutes.detail(state.items[index].id)),
            )
          : _Footer(state: state),
    );
  }
}

/// Под списком: индикатор догрузки или ошибка с «Повторить».
class _Footer extends StatelessWidget {
  const _Footer({required this.state});

  final PokemonListLoaded state;

  @override
  Widget build(BuildContext context) {
    final error = state.loadMoreError;
    return Center(
      child: error == null
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          : LoadErrorView(
              error: error,
              onRetry: context.read<PokemonListCubit>().loadMore,
            ),
    );
  }
}
