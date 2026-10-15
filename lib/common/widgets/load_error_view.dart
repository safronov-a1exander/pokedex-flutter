import 'package:flutter/material.dart';
import 'package:pokedex/common/network/load_exception.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Сообщение об ошибке загрузки и кнопка «Повторить».
///
/// Пользователь видит понятную фразу, а не `DioException [...]`. Кнопки нет
/// там, где повтор не поможет: записи, которой нет, не появится.
class LoadErrorView extends StatelessWidget {
  const LoadErrorView({super.key, required this.error, required this.onRetry});

  final LoadException error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final message = switch (error) {
      NoConnectionException() => l10n.errorNoConnection,
      TimeoutLoadException() => l10n.errorTimeout,
      NotFoundException() => l10n.errorNotFound,
      ServerException(:final statusCode) => l10n.errorServer(
        statusCode?.toString() ?? '?',
      ),
      BadResponseException() => l10n.errorBadResponse,
    };
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Text(message, textAlign: TextAlign.center),
          if (error is! NotFoundException)
            FilledButton.tonal(
              onPressed: onRetry,
              child: Text(l10n.actionRetry),
            ),
        ],
      ),
    );
  }
}
