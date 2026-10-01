import 'package:flutter/material.dart';

/// Подложка карточки списка: скруглённые углы, тень, отступ содержимого и
/// отклик на нажатие.
class CardSurface extends StatelessWidget {
  const CardSurface({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(12), child: child),
      ),
    );
  }
}
