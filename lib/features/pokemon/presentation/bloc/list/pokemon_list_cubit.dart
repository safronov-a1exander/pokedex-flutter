import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokemon/data/mock_pokemons.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_state.dart';

/// Состояние экрана списка меняется только здесь.
///
/// Экран вызывает публичные методы Cubit и получает новое состояние через
/// BlocBuilder. Метод emit защищённый: вызвать его снаружи анализатор не даст.
///
/// Пока записи берутся прямо из моков. На шаге 1 между Cubit и моками встанет
/// репозиторий.
class PokemonListCubit extends Cubit<PokemonListState> {
  PokemonListCubit() : super(const PokemonListState());

  void load() {
    emit(state.copyWith(items: mockPokemons));
  }
}
