import 'package:pokedex/data/models/pokedex.dart';
import 'package:pokedex/data/repositories/pokemon_repository.dart';

abstract class GetPokemonInfoUseCase {
  Future<PokemonProfile?> execute(int numberPokemon);
}

class GetPokemonInfoUseCaseImpl implements GetPokemonInfoUseCase {
  final PokemonRepository repository;

  GetPokemonInfoUseCaseImpl({PokemonRepository? repository})
    : this.repository = repository ?? PokemonRepository();

  @override
  Future<PokemonProfile?> execute(int numberPokemon) async {
    return await repository.getPokemonProfileData(numberPokemon);
  }
}
