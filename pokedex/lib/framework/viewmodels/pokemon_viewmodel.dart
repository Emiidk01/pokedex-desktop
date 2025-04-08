import 'package:flutter/foundation.dart';
import 'package:pokedex/data/models/pokemonBase.dart';
import 'package:pokedex/domain/get_pokemon_info_usecase.dart';
import 'package:pokedex/domain/get_pokemon_list_usecase.dart';
import '../../data/models/pokedex.dart';
import '../../data/repositories/pokemon_repository.dart';

class PokemonListViewModel extends ChangeNotifier {
  final PokemonRepository repository = PokemonRepository();
  final GetPokemonListUseCase getPokemonListUseCase;
  final GetPokemonInfoUseCase getPokemonInfoUseCase;

  List<PokemonBase> pokemonList = [];
  bool isLoading = true;

  // Constructor con inyección de dependencias
  PokemonListViewModel({
    GetPokemonListUseCase? getPokemonListUseCase,
    GetPokemonInfoUseCase? getPokemonInfoUseCase,
  }) : getPokemonListUseCase =
           getPokemonListUseCase ?? GetPokemonListUseCaseImpl(),
       getPokemonInfoUseCase =
           getPokemonInfoUseCase ?? GetPokemonInfoUseCaseImpl();

  Future<void> loadPokemonList() async {
    isLoading = true;
    notifyListeners();

    try {
      final pokedex = await getPokemonListUseCase.execute(20);

      if (pokedex != null) {
        for (var pokemon in pokedex.results) {
          final urlParts = pokemon.url.split('/');
          final pokemonNumber = int.parse(urlParts[urlParts.length - 2]);

          final profile = await getPokemonInfoUseCase.execute(pokemonNumber);

          final pokemonBase = PokemonBase(
            id: pokemonNumber,
            pokemon: pokemon,
            profile: profile,
          );

          pokemonList.add(pokemonBase);
          notifyListeners(); // Notifica a los oyentes para actualizar la UI
        }
      }
    } catch (e) {
      print('Error al cargar la lista de Pokémon: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
