import 'package:flutter/material.dart';
import 'package:pokedex/common/theme/image_sources.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/presentation/utils/pokemon_type_format.dart';

/// Как запись выглядит на экране.
///
/// Модель хранит данные как в API. Перевод в вид для показа собран здесь:
/// экраны и виджеты берут готовое значение и сами ничего не пересчитывают.
extension PokemonFormat on PokemonModel {
  /// bulbasaur → Bulbasaur.
  String get displayName => _capitalize(name);

  /// Номер по национальному покедексу: 1 → 001.
  String get displayNumber => id.toString().padLeft(3, '0');

  /// В API рост в дециметрах.
  double get heightM => heightDm / 10;

  /// В API вес в гектограммах.
  double get weightKg => weightHg / 10;

  String get sprite => ImageSources.sprite(id);

  /// Цвет первого типа: им красятся подложка картинки и полосы характеристик.
  Color get accent => types.first.color;
}

extension AbilityFormat on AbilityModel {
  /// overgrow → Overgrow.
  String get displayName => _capitalize(name);
}

String _capitalize(String text) =>
    text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
