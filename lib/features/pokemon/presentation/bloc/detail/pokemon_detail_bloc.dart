import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/network/load_exception.dart';
import 'package:pokedex/features/pokemon/domain/i_pokemon_repository.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/detail/pokemon_detail_event.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/detail/pokemon_detail_state.dart';

/// Состояние экрана детали меняется только здесь.
///
/// Это Bloc, а не Cubit: экран не вызывает методы, а передаёт события через
/// add. Открытие экрана и «Повторить» обрабатываются одинаково: загрузить
/// запись заново.
class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  PokemonDetailBloc(this._repository) : super(const PokemonDetailLoading()) {
    on<PokemonDetailOpened>(_onLoadRequested);
    on<PokemonDetailRetried>(_onLoadRequested);
  }

  final IPokemonRepository _repository;

  Future<void> _onLoadRequested(
    PokemonDetailEvent event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(const PokemonDetailLoading());
    try {
      final details = await _repository.getDetails(event.id);
      // Проверять isClosed, как в Cubit, не нужно: когда Bloc закрывают,
      // обработчик отменяется, и emit после этого ничего не делает. Сам
      // запрос при этом всё равно доедет: Future не отменяется.
      emit(PokemonDetailLoaded(details));
    } on NotFoundException {
      emit(PokemonDetailNotFound(event.id));
    } on LoadException catch (error) {
      emit(PokemonDetailFailure(event.id, error));
    }
  }
}
