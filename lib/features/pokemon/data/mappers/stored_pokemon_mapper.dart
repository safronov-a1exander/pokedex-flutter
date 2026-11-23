import 'package:pokedex/features/pokemon/data/dto/stored_pokemon_dto.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';

/// Модель → формат хранилища. Нужен при записи.
extension PokemonModelStoredMapper on PokemonModel {
  StoredPokemonDto toStored() => StoredPokemonDto(
    id: id,
    name: name,
    imageUrl: imageUrl,
    types: [for (final type in types) type.name],
    heightDm: heightDm,
    weightHg: weightHg,
    baseExperience: baseExperience,
    abilities: [
      for (final ability in abilities)
        StoredAbilityDto(name: ability.name, hidden: ability.hidden),
    ],
    stats: [
      for (final stat in stats) StoredStatDto(key: stat.key, value: stat.value),
    ],
  );
}

/// Формат хранилища → модель. Нужен при чтении.
extension StoredPokemonDtoMapper on StoredPokemonDto {
  PokemonModel toModel() => PokemonModel(
    id: id,
    name: name,
    imageUrl: imageUrl,
    types: [for (final type in types) ?_typesByName[type]],
    heightDm: heightDm,
    weightHg: weightHg,
    baseExperience: baseExperience,
    abilities: [
      for (final ability in abilities)
        AbilityModel(ability.name, hidden: ability.hidden),
    ],
    stats: [for (final stat in stats) StatModel(stat.key, stat.value)],
  );
}

final Map<String, PokemonType> _typesByName = PokemonType.values.asNameMap();
