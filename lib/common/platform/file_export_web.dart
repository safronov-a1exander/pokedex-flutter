import 'dart:js_interop';

import 'package:pokedex/common/platform/export_result.dart';
import 'package:web/web.dart' as web;

/// Браузер: файловой системы нет. Собираем файл в памяти (Blob) и просим
/// браузер его скачать, как по ссылке «скачать». Куда он ляжет, решает
/// браузер, приложение этого не узнает.
Future<ExportResult> exportTextFile(String fileName, String content) async {
  final blob = web.Blob(
    [content.toJS].toJS,
    web.BlobPropertyBag(type: 'text/csv;charset=utf-8'),
  );
  final url = web.URL.createObjectURL(blob);
  web.HTMLAnchorElement()
    ..href = url
    ..download = fileName
    ..click();
  // Ссылку на файл в памяти освобождаем не сразу: браузеру нужно время,
  // чтобы начать скачивание.
  Future<void>.delayed(
    const Duration(seconds: 1),
    () => web.URL.revokeObjectURL(url),
  );
  return const Downloaded();
}
