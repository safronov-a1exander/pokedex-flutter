import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/platform/export_result.dart';
import 'package:pokedex/features/pokemon/domain/i_favorites_repository.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Избранное. Состояние — сами записи, целиком: экран избранного рисует их
/// без сети.
///
/// Cubit создаётся в корне: звезда на детали и экран избранного смотрят в
/// одно и то же состояние.
class FavoritesCubit extends Cubit<List<PokemonModel>> {
  FavoritesCubit(this._repository) : super(const []);

  final IFavoritesRepository _repository;

  /// Читает избранное с диска. Вызывается при запуске приложения.
  Future<void> load() async {
    final items = await _repository.getAll();
    if (!isClosed) emit(items);
  }

  bool contains(int id) => state.any((item) => item.id == id);

  /// Звезда на детали: добавить или убрать запись.
  Future<void> toggle(PokemonModel pokemon) async {
    final next = contains(pokemon.id)
        ? [
            for (final item in state)
              if (item.id != pokemon.id) item,
          ]
        : [...state, pokemon];
    // Экран обновляем сразу, запись на диск идёт следом.
    emit(next);
    await _repository.saveAll(next);
  }

  /// Кнопка «Экспортировать». Результат одноразовый, его показывает
  /// SnackBar, поэтому он возвращается экрану, а не кладётся в состояние.
  Future<ExportResult> export() => _repository.export(state);
}
