import 'package:pokedex/common/platform/export_result.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';

/// Избранное. Хранится на устройстве и открывается без сети.
abstract interface class IFavoritesRepository {
  Future<List<PokemonModel>> getAll();

  /// Сохраняет избранное целиком: хранилище «ключ → строка» пишет всё сразу.
  Future<void> saveAll(List<PokemonModel> items);

  /// Отдаёт избранное файлом. Что получилось, зависит от платформы.
  Future<ExportResult> export(List<PokemonModel> items);
}
