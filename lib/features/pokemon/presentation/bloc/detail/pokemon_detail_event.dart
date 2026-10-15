/// События экрана детали.
///
/// У Bloc один вход: событие, переданное в add. Поэтому даже загрузка записи
/// при открытии экрана оформлена событием.
sealed class PokemonDetailEvent {
  const PokemonDetailEvent(this.id);

  /// Какую запись загрузить.
  final int id;
}

/// Экран открыт, нужно загрузить запись.
final class PokemonDetailOpened extends PokemonDetailEvent {
  const PokemonDetailOpened(super.id);
}

/// Загрузка упала, пользователь нажал «Повторить».
final class PokemonDetailRetried extends PokemonDetailEvent {
  const PokemonDetailRetried(super.id);
}
