import 'package:pokedex/common/network/load_exception.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Состояние экрана списка.
///
/// Класс sealed: «грузится», «есть данные» и «ошибка» не могут оказаться
/// правдой одновременно, и экран обязан разобрать все три варианта. Запрос
/// поиска есть в каждом варианте.
sealed class PokemonListState {
  const PokemonListState({required this.query});

  /// Текст поиска. Пустая строка значит, что поиск не задан.
  final String query;
}

final class PokemonListLoading extends PokemonListState {
  const PokemonListLoading({required super.query});
}

final class PokemonListLoaded extends PokemonListState {
  const PokemonListLoaded({
    required super.query,
    required this.items,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<PokemonModel> items;

  /// На сервере есть ещё страницы. У результатов поиска страниц нет.
  final bool hasMore;

  /// Догружается следующая страница: внизу списка индикатор.
  final bool isLoadingMore;

  /// Следующая страница не загрузилась. Уже загруженные записи остаются на
  /// экране, внизу кнопка «Повторить».
  final LoadException? loadMoreError;
}

final class PokemonListFailure extends PokemonListState {
  const PokemonListFailure({required super.query, required this.error});

  final LoadException error;
}
