/// Пути к картинкам из `assets/`.
///
/// Путь к ассету — обычная строка, и опечатку в нём видно только на экране.
/// Поэтому пути собираются в одном месте.
abstract final class ImageSources {
  /// Картинка записи. Лежит в репозитории, сеть для неё не нужна.
  static String sprite(int id) {
    assert(id >= 1 && id <= 20, 'Картинки для записи $id нет в assets/sprites');
    return 'assets/sprites/pokemon_$id.png';
  }
}
