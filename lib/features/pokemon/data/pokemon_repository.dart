import 'dart:async';

import 'package:pokedex/common/network/load_exception.dart';
import 'package:pokedex/features/pokemon/data/data_sources/i_local_pokemon_data_source.dart';
import 'package:pokedex/features/pokemon/data/data_sources/i_pokemon_data_source.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_species_dto.dart';
import 'package:pokedex/features/pokemon/data/mappers/pokemon_mapper.dart';
import 'package:pokedex/features/pokemon/data/mappers/stored_pokemon_mapper.dart';
import 'package:pokedex/features/pokemon/domain/i_pokemon_repository.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_page_model.dart';

/// Репозиторий на двух датасорсах: сетевом и локальном.
///
/// Репозиторий берёт DTO у датасорсов и отдаёт наверх только модели
/// приложения. Где взять данные, решает он: Cubit про кэш не знает, он видит
/// только флаг [PokemonPageModel.fromCache].
final class PokemonRepository implements IPokemonRepository {
  PokemonRepository(this._network, this._local);

  final IPokemonDataSource _network;
  final ILocalPokemonDataSource _local;

  /// Имена всех записей для поиска. Загружаются при первом поиске и живут в
  /// памяти, пока работает приложение.
  List<String>? _allNames;

  static const int _searchLimit = 20;

  @override
  Future<PokemonPageModel> getPokemons({
    required int offset,
    required int limit,
  }) async {
    try {
      final page = await _network.getPokemonPage(offset: offset, limit: limit);
      // В странице только имена. Типы и картинку отдаёт адрес каждой записи,
      // поэтому за страницей идут ещё [limit] запросов, все сразу.
      final items = await _loadAll([
        for (final item in page.results) item.name,
      ]);
      // Сеть ответила: сохраняем страницу на случай, когда сети не будет.
      // Каждую страницу отдельно: до конца списка можно и не долистать.
      await _local.savePage(
        offset: offset,
        limit: limit,
        items: [for (final item in items) item.toStored()],
      );
      return PokemonPageModel(items: items, fromCache: false);
    } on LoadException catch (error) {
      // Кэш нужен, только когда сеть не ответила. Ошибку сервера и 404 им не
      // прикрываем: сервер ответил, и ответ надо показать.
      if (error is! NoConnectionException && error is! TimeoutLoadException) {
        rethrow;
      }
      final cached = await _local.getPage(offset: offset, limit: limit);
      // Сохранённого нет: экран покажет ту же ошибку, что и без кэша.
      if (cached == null) rethrow;
      return PokemonPageModel(
        items: [for (final item in cached) item.toModel()],
        fromCache: true,
      );
    }
  }

  @override
  Future<PokemonDetailsModel> getDetails(int id) async {
    final PokemonDto pokemon;
    final PokemonSpeciesDto species;
    try {
      // Запись и её вид не зависят друг от друга: два запроса идут
      // параллельно, ждём оба.
      (pokemon, species) = await (
        _network.getPokemon('$id'),
        _network.getSpecies(id),
      ).wait;
    } on ParallelWaitError<
      (PokemonDto?, PokemonSpeciesDto?),
      (AsyncError?, AsyncError?)
    > catch (error) {
      // .wait у пары бросает не исходную ошибку, а ParallelWaitError с
      // ошибками обоих запросов. Наверх отдаём первую, это LoadException.
      final first = (error.errors.$1 ?? error.errors.$2)!;
      Error.throwWithStackTrace(first.error, first.stackTrace);
    }

    final chain = await _network.getEvolutionChain(species.evolutionChainId);
    final evolution = await _loadAll([
      for (final stageId in chain.speciesIds) '$stageId',
    ]);
    return PokemonDetailsModel(
      pokemon: pokemon.toModel(),
      genus: species.englishGenus,
      flavorText: species.englishFlavorText,
      evolution: evolution,
    );
  }

  @override
  Future<List<PokemonModel>> searchPokemons(String query) async {
    // Поиска по имени на сервере нет. Список всех имён весит около 100 КБ,
    // его загружаем один раз и ищем в памяти.
    final names = _allNames ??= await _loadAllNames();
    final needle = query.trim().toLowerCase();
    return _loadAll(
      names.where((name) => name.contains(needle)).take(_searchLimit),
    );
  }

  Future<List<String>> _loadAllNames() async {
    final first = await _network.getPokemonPage(offset: 0, limit: 1);
    final all = await _network.getPokemonPage(offset: 0, limit: first.count);
    return [for (final item in all.results) item.name];
  }

  /// Записи по именам или номерам, все запросы сразу. Future.wait, в отличие
  /// от .wait у пары, пробрасывает исходную ошибку первого упавшего запроса.
  Future<List<PokemonModel>> _loadAll(Iterable<String> idsOrNames) async {
    final dtos = await Future.wait([
      for (final idOrName in idsOrNames) _network.getPokemon(idOrName),
    ]);
    return [for (final dto in dtos) dto.toModel()];
  }
}
