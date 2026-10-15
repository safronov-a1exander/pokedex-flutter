/// Почему не удалось загрузить данные.
///
/// Датасорс переводит в эти классы ошибки dio и разбора ответа. Выше датасорса
/// про dio никто не знает: Cubit и Bloc ловят только [LoadException].
///
/// Класс sealed: экран разбирает все варианты через switch, и забыть один не
/// даст компилятор.
sealed class LoadException implements Exception {
  const LoadException();
}

/// Нет сети или сервер недоступен. В браузере сюда же попадает ответ без
/// заголовка CORS: браузер не говорит приложению, что дело в нём.
final class NoConnectionException extends LoadException {
  const NoConnectionException();
}

/// Сервер не ответил за отведённое время.
final class TimeoutLoadException extends LoadException {
  const TimeoutLoadException();
}

/// Сервер ответил 404: такой записи нет.
final class NotFoundException extends LoadException {
  const NotFoundException();
}

/// Сервер ответил ошибкой, кроме 404.
final class ServerException extends LoadException {
  const ServerException(this.statusCode);

  final int? statusCode;
}

/// Ответ пришёл, но разобрать его не удалось: другие поля, другие типы,
/// оборванный JSON.
final class BadResponseException extends LoadException {
  const BadResponseException();
}
