import 'package:flutter/material.dart';

/// Цвета приложения, заданные числом.
///
/// [seed] — опорный цвет темы: из него строится вся палитра светлой и тёмной
/// темы. Цвета типов к теме не относятся. Они часть данных, и трава остаётся
/// зелёной в любой теме.
abstract final class AppColors {
  static const Color seed = Color(0xFFB3261E);

  static const Color typeNormal = Color(0xFF8A8A5E);
  static const Color typeFighting = Color(0xFFB23A2E);
  static const Color typeFlying = Color(0xFF8E7BD8);
  static const Color typePoison = Color(0xFF8E3A8E);
  static const Color typeGround = Color(0xFFA9803A);
  static const Color typeRock = Color(0xFF94812E);
  static const Color typeBug = Color(0xFF7A8B14);
  static const Color typeGhost = Color(0xFF5E4C8C);
  static const Color typeSteel = Color(0xFF6F7290);
  static const Color typeFire = Color(0xFFE25822);
  static const Color typeWater = Color(0xFF4C74D9);
  static const Color typeGrass = Color(0xFF4E9A2F);
  static const Color typeElectric = Color(0xFFB38F00);
  static const Color typePsychic = Color(0xFFD9467A);
  static const Color typeIce = Color(0xFF3F9696);
  static const Color typeDragon = Color(0xFF5A33D6);
  static const Color typeDark = Color(0xFF5A4636);
  static const Color typeFairy = Color(0xFFC2649A);
}
