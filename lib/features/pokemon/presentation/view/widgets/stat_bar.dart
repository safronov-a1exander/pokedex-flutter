import 'package:flutter/material.dart';

/// Строка характеристики: подпись, число и полоса.
///
/// Подложка полосы берётся из темы, заполнение цветом типа. Оформление
/// следует за темой, цвет типа от неё не зависит.
class StatBar extends StatelessWidget {
  const StatBar({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  /// Значение, при котором полоса заполнена целиком. У первых двадцати
  /// записей максимум 109.
  static const double _full = 150;

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        SizedBox(
          width: 36,
          child: Text(
            '$value',
            textAlign: TextAlign.end,
            style: theme.textTheme.labelLarge,
          ),
        ),
        const SizedBox(width: 12),
        // Expanded обязателен: без него Row отдаст полосе бесконечную ширину,
        // и FractionallySizedBox упадёт.
        Expanded(
          child: Container(
            height: 8,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              widthFactor: (value / _full).clamp(0.0, 1.0),
              heightFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
