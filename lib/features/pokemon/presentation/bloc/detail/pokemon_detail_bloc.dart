import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokemon/domain/i_pokemon_repository.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/detail/pokemon_detail_event.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/detail/pokemon_detail_state.dart';

/// Состояние экрана детали меняется только здесь.
///
/// Это Bloc, а не Cubit: экран не вызывает методы, а передаёт события через
/// add. На каждый тип события в конструкторе регистрируется обработчик on.
///
/// Bloc не знает ни про виджеты, ни про навигацию. Он получает событие,
/// читает репозиторий и выдаёт новое состояние.
class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  PokemonDetailBloc(this._repository) : super(const PokemonDetailLoading()) {
    on<PokemonDetailOpened>(_onOpened);
  }

  final IPokemonRepository _repository;

  Future<void> _onOpened(
    PokemonDetailOpened event,
    Emitter<PokemonDetailState> emit,
  ) async {
    final pokemon = await _repository.getPokemon(event.id);
    if (pokemon == null) {
      emit(PokemonDetailNotFound(event.id));
      return;
    }
    final evolution = <PokemonModel>[];
    for (final stageId in pokemon.evolutionChain) {
      final stage = await _repository.getPokemon(stageId);
      if (stage != null) evolution.add(stage);
    }
    // Проверять isClosed, как в Cubit, не нужно: когда Bloc закрывают,
    // обработчик отменяется, и emit после этого ничего не делает.
    emit(PokemonDetailLoaded(pokemon, evolution: evolution));
  }
}
