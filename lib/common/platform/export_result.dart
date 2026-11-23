/// Чем кончился экспорт файла.
///
/// Не bool и не путь строкой: «файл» на каждой платформе значит своё. На
/// desktop и Android файл ложится на диск и путь известен. В браузере
/// файловой системы нет, файл отдаётся браузеру на скачивание, и куда он
/// попал, приложение не узнает. Где платформа не умеет совсем, так и говорим.
sealed class ExportResult {
  const ExportResult();
}

/// Файл записан на диск по пути [path].
final class SavedTo extends ExportResult {
  const SavedTo(this.path);

  final String path;
}

/// Файл отдан браузеру на скачивание.
final class Downloaded extends ExportResult {
  const Downloaded();
}

/// На этой платформе записать файл нечем.
final class NotSupported extends ExportResult {
  const NotSupported();
}

/// Записать пытались, но не вышло: нет места, нет прав.
final class ExportFailed extends ExportResult {
  const ExportFailed(this.reason);

  final String reason;
}
