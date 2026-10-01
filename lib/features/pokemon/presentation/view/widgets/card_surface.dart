import 'package:flutter/material.dart';

/// Подложка карточки списка: скруглённые углы, тень, отступ содержимого и
/// отклик на нажатие.
///
/// Цвет берётся из ColorScheme, а не задаётся числом. Цвет текста приходит
/// из темы: в тёмной теме текст светлеет. Белая подложка, заданная числом,
/// осталась бы белой, и светлое имя на ней было бы не прочитать.
class CardSurface extends StatelessWidget {
  const CardSurface({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      color: Theme.of(context).colorScheme.surfaceContainer,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(12), child: child),
      ),
    );
  }
}
