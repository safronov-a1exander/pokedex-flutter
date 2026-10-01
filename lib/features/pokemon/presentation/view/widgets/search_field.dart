import 'package:flutter/material.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Поле поиска. Каждую правку текста отдаёт наверх через [onChanged].
///
/// Виджет с состоянием, потому что TextField нужен TextEditingController.
/// Контроллер создаётся один раз в initState, а не в build: иначе каждая
/// пересборка сбрасывала бы текст и курсор. Освобождается контроллер в
/// dispose.
class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// clear() не вызывает onChanged у TextField, поэтому пустой запрос
  /// отправляется наверх отдельно.
  void _clear() {
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: l10n.searchHint,
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          tooltip: l10n.actionClearSearch,
          icon: const Icon(Icons.clear),
          onPressed: _clear,
        ),
      ),
    );
  }
}
