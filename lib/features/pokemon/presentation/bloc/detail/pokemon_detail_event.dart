/// События экрана детали.
///
/// У Bloc один вход: событие, переданное в add. Поэтому даже загрузка записи
/// при открытии экрана оформлена событием.
sealed class PokemonDetailEvent {
  const PokemonDetailEvent();
}

/// Экран открыт, нужно загрузить запись [id].
final class PokemonDetailOpened extends PokemonDetailEvent {
  const PokemonDetailOpened(this.id);

  final int id;
}
