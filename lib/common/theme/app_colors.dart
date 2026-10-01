import 'package:flutter/material.dart';

/// Цвета приложения, заданные числом.
///
/// [seed] — опорный цвет темы: из него строится вся палитра светлой и тёмной
/// темы. Цвета типов к теме не относятся. Они часть данных, и трава остаётся
/// зелёной в любой теме.
abstract final class AppColors {
  static const Color seed = Color(0xFFB3261E);

  static const Color typeBug = Color(0xFF7A8B14);
  static const Color typeFire = Color(0xFFE25822);
  static const Color typeFlying = Color(0xFF8E7BD8);
  static const Color typeGrass = Color(0xFF4E9A2F);
  static const Color typeNormal = Color(0xFF8A8A5E);
  static const Color typePoison = Color(0xFF8E3A8E);
  static const Color typeWater = Color(0xFF4C74D9);
}
