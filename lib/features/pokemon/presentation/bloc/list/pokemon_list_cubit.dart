import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/network/load_exception.dart';
import 'package:pokedex/features/pokemon/domain/i_pokemon_repository.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_state.dart';

/// Состояние экрана списка меняется только здесь.
///
/// Экран вызывает публичные методы Cubit и получает новое состояние через
/// BlocBuilder. Cubit знает только [IPokemonRepository] и [LoadException]:
/// про dio, JSON и DTO он не знает.
class PokemonListCubit extends Cubit<PokemonListState> {
  PokemonListCubit(this._repository)
    : super(const PokemonListLoading(query: ''));

  final IPokemonRepository _repository;

  static const int _pageSize = 20;

  /// Пауза после последней буквы, прежде чем искать.
  static const Duration _searchDelay = Duration(milliseconds: 400);

  Timer? _searchTimer;

  /// Первая страница. Вызывается при запуске приложения.
  Future<void> load() => _load('');

  /// Кнопка «Повторить» на экране ошибки.
  Future<void> retry() => _load(state.query);

  /// Запрос уходит не на каждую букву, а через [_searchDelay] после
  /// последней. Каждая новая буква отменяет таймер предыдущей.
  void search(String query) {
    _searchTimer?.cancel();
    _searchTimer = Timer(_searchDelay, () => _load(query.trim()));
  }

  /// Следующая страница. Экран вызывает метод, когда список докручен почти до
  /// конца, и может вызвать его несколько раз подряд. Лишние вызовы
  /// отсекаются здесь.
  Future<void> loadMore() async {
    final current = state;
    if (current is! PokemonListLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }
    emit(
      PokemonListLoaded(
        query: current.query,
        items: current.items,
        hasMore: true,
        isLoadingMore: true,
      ),
    );
    try {
      final next = await _repository.getPokemons(
        // Смещение считаем по тому, что уже показано: без дублей и пропусков.
        offset: current.items.length,
        limit: _pageSize,
      );
      if (isClosed || state.query != current.query) return;
      emit(
        PokemonListLoaded(
          query: current.query,
          items: [...current.items, ...next],
          hasMore: next.length == _pageSize,
        ),
      );
    } on LoadException catch (error) {
      if (isClosed || state.query != current.query) return;
      emit(
        PokemonListLoaded(
          query: current.query,
          items: current.items,
          hasMore: true,
          loadMoreError: error,
        ),
      );
    }
  }

  Future<void> _load(String query) async {
    emit(PokemonListLoading(query: query));
    try {
      final items = query.isEmpty
          ? await _repository.getPokemons(offset: 0, limit: _pageSize)
          : await _repository.searchPokemons(query);
      // Пока ждали ответ, Cubit могли закрыть, а пользователь мог ввести
      // новый запрос. Тогда этот ответ уже никому не нужен.
      if (isClosed || state.query != query) return;
      emit(
        PokemonListLoaded(
          query: query,
          items: items,
          hasMore: query.isEmpty && items.length == _pageSize,
        ),
      );
    } on LoadException catch (error) {
      if (isClosed || state.query != query) return;
      emit(PokemonListFailure(query: query, error: error));
    }
  }

  /// Таймер поиска тоже ресурс: закрыли Cubit, отменяем и его.
  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
