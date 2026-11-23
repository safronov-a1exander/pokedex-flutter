import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokedex/common/platform/export_result.dart';

/// Android, iOS, desktop: файл ложится в папку загрузок, а если её у
/// платформы нет, в документы приложения.
///
/// На Android папка загрузок здесь своя у приложения
/// (`Android/data/<пакет>/files/Download`): общая папка загрузок требует
/// другого API. Путь показываем пользователю как есть.
Future<ExportResult> exportTextFile(String fileName, String content) async {
  final Directory directory;
  try {
    directory =
        await getDownloadsDirectory() ??
        await getApplicationDocumentsDirectory();
  } on MissingPluginException {
    // У платформы нет реализации path_provider: писать некуда.
    return const NotSupported();
  } on UnsupportedError {
    return const NotSupported();
  }
  try {
    final file = File('${directory.path}${Platform.pathSeparator}$fileName');
    await file.writeAsString(content);
    return SavedTo(file.path);
  } on FileSystemException catch (error) {
    return ExportFailed(error.message);
  }
}
