import 'package:dio/dio.dart';
import 'package:pokedex/features/pokemon/data/dto/evolution_chain_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_page_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_species_dto.dart';

/// API-клиент: один метод на один адрес сервера, ответ разбирается в DTO.
///
/// Клиент знает адреса и параметры запросов, но не знает, что делать с
/// ошибками и как устроены модели приложения. Это задачи датасорса и
/// репозитория.
final class PokemonApi {
  const PokemonApi(this._dio);

  final Dio _dio;

  Future<PokemonPageDto> getPokemonPage({
    required int offset,
    required int limit,
  }) async {
    final json = await _getJson(
      '/pokemon',
      queryParameters: {'offset': offset, 'limit': limit},
    );
    return PokemonPageDto.fromJson(json);
  }

  /// [idOrName]: сервер принимает и номер, и имя записи.
  Future<PokemonDto> getPokemon(String idOrName) async =>
      PokemonDto.fromJson(await _getJson('/pokemon/$idOrName'));

  Future<PokemonSpeciesDto> getSpecies(int id) async =>
      PokemonSpeciesDto.fromJson(await _getJson('/pokemon-species/$id'));

  Future<EvolutionChainDto> getEvolutionChain(int id) async =>
      EvolutionChainDto.fromJson(await _getJson('/evolution-chain/$id'));

  /// dio сам разбирает JSON в Map. Пустой ответ здесь не ждём.
  Future<Map<String, dynamic>> _getJson(
    String path, {
    Map<String, Object>? queryParameters,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
    );
    return response.data ?? (throw const FormatException('Пустой ответ'));
  }
}
