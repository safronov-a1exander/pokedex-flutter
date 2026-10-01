import 'package:flutter/material.dart';

/// Бейдж типа: подпись на плашке цвета типа.
///
/// Белый текст здесь задан числом, и это правильно. Подпись лежит на цвете
/// типа, а цвет типа от темы не зависит. Значит, и цвет подписи от неё
/// зависеть не должен.
class TypeChip extends StatelessWidget {
  const TypeChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
