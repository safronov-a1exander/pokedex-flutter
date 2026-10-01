import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokemon/domain/i_pokemon_repository.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_state.dart';

/// Состояние экрана списка меняется только здесь.
///
/// Экран вызывает публичные методы Cubit и получает новое состояние через
/// BlocBuilder. Метод emit защищённый: вызвать его снаружи анализатор не даст.
///
/// Записи Cubit берёт у [IPokemonRepository]. Какая реализация стоит за
/// интерфейсом, решает app.dart.
class PokemonListCubit extends Cubit<PokemonListState> {
  PokemonListCubit(this._repository) : super(const PokemonListState());

  final IPokemonRepository _repository;

  Future<void> load() async {
    final items = await _repository.getPokemons();
    // Пока ждали ответ, Cubit могли закрыть. emit после close — ошибка.
    if (isClosed) return;
    emit(state.copyWith(items: items));
  }
}
