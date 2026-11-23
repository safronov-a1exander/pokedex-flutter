// Экспорт текстового файла. Реализаций две, и выбирает их не if в коде, а
// условный импорт при сборке: в браузере берётся file_export_web.dart, на
// остальных платформах file_export_io.dart. В web-сборку не попадает dart:io,
// а в остальные не попадает код для браузера.
export 'file_export_io.dart'
    if (dart.library.js_interop) 'file_export_web.dart';
export 'export_result.dart';
