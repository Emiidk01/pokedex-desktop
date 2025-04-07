import 'package:pokedex/data/models/pokedex.dart';
import 'package:pokedex/data/repositories/pokemon_repository.dart';

abstract class GetPokemonListUseCase {
  Future<Pokedex?> execute(int limit);
}

class GetPokemonListUseCaseImpl implements GetPokemonListUseCase {
  final PokemonRepository repository;

  GetPokemonListUseCaseImpl({PokemonRepository? repository})
    : this.repository = repository ?? PokemonRepository();

  @override
  Future<Pokedex?> execute(int limit) async {
    return await repository.getPokedexData(limit);
  }
}