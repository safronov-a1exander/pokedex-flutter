import 'package:pokedex/common/network/load_exception.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_details_model.dart';

/// Состояние экрана детали.
///
/// Класс sealed: switch по состоянию обязан разобрать все варианты, иначе код
/// не скомпилируется.
sealed class PokemonDetailState {
  const PokemonDetailState();
}

final class PokemonDetailLoading extends PokemonDetailState {
  const PokemonDetailLoading();
}

final class PokemonDetailLoaded extends PokemonDetailState {
  const PokemonDetailLoaded(this.details);

  final PokemonDetailsModel details;
}

/// Записи с таким номером нет: сервер ответил 404. В вебе адрес /pokemon/99999
/// можно ввести руками, и для него нужен свой экран. Повторять тут нечего.
final class PokemonDetailNotFound extends PokemonDetailState {
  const PokemonDetailNotFound(this.id);

  final int id;
}

/// Загрузка упала по любой другой причине. Можно повторить.
final class PokemonDetailFailure extends PokemonDetailState {
  const PokemonDetailFailure(this.id, this.error);

  final int id;
  final LoadException error;
}
