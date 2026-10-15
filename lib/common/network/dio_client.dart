import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Создание Dio. Базовый адрес и таймауты записаны только здесь.
///
/// Dio создаётся один раз в app.dart и передаётся дальше через конструкторы.
abstract final class DioClient {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        // Без таймаутов запрос к зависшему серверу ждёт сколько угодно.
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
    // Интерсептор видит каждый запрос. Этот пишет их в консоль, только в
    // debug: в release лог не нужен.
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestHeader: false,
          responseHeader: false,
          logPrint: (line) => debugPrint('[dio] $line'),
        ),
      );
    }
    return dio;
  }
}
