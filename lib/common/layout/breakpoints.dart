import 'package:flutter/widgets.dart';

/// Ширина окна, с которой список и деталь помещаются рядом.
///
/// Решаем по ширине окна, а не по платформе: окно браузера и окно desktop
/// бывают узкими, планшет широким. 840 — порог «расширенной» ширины в
/// Material, тот же, что у Compose Multiplatform на Л5.
abstract final class Breakpoints {
  static const double expanded = 840;

  /// Окно достаточно широкое для двух панелей. Ширина берётся у окна целиком,
  /// а не у родителя: вопрос «сколько панелей» про всё окно.
  static bool isExpanded(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= expanded;
}
