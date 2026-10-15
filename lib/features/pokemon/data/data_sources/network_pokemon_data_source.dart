import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/common/network/load_exception.dart';
import 'package:pokedex/features/pokemon/data/api/pokemon_api.dart';
import 'package:pokedex/features/pokemon/data/data_sources/i_pokemon_data_source.dart';
import 'package:pokedex/features/pokemon/data/dto/evolution_chain_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_page_dto.dart';
import 'package:pokedex/features/pokemon/data/dto/pokemon_species_dto.dart';

/// Данные из сети через [PokemonApi].
///
/// Главная работа датасорса: ошибки dio и разбора ответа здесь превращаются
/// в [LoadException]. Выше про dio никто не знает.
final class NetworkPokemonDataSource implements IPokemonDataSource {
  const NetworkPokemonDataSource(this._api);

  final PokemonApi _api;

  @override
  Future<PokemonPageDto> getPokemonPage({
    required int offset,
    required int limit,
  }) => _guard(() => _api.getPokemonPage(offset: offset, limit: limit));

  @override
  Future<PokemonDto> getPokemon(String idOrName) =>
      _guard(() => _api.getPokemon(idOrName));

  @override
  Future<PokemonSpeciesDto> getSpecies(int id) =>
      _guard(() => _api.getSpecies(id));

  @override
  Future<EvolutionChainDto> getEvolutionChain(int id) =>
      _guard(() => _api.getEvolutionChain(id));

  /// await внутри try обязателен: без него ошибка Future пройдёт мимо catch.
  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _fromDio(error);
    } on CheckedFromJsonException {
      // Поле не того типа или его нет: ответ не той формы, что описана в DTO.
      throw const BadResponseException();
    } on FormatException {
      throw const BadResponseException();
    }
  }

  LoadException _fromDio(DioException error) => switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const TimeoutLoadException(),
    DioExceptionType.badResponse when error.response?.statusCode == 404 =>
      const NotFoundException(),
    DioExceptionType.badResponse => ServerException(error.response?.statusCode),
    // Оборванный или испорченный JSON dio отдаёт как unknown с
    // FormatException внутри.
    DioExceptionType.unknown when error.error is FormatException =>
      const BadResponseException(),
    DioExceptionType.connectionError ||
    DioExceptionType.badCertificate ||
    DioExceptionType.cancel ||
    DioExceptionType.unknown => const NoConnectionException(),
  };
}
