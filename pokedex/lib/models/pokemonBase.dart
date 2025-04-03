import 'package:pokedex/models/pokedex.dart';

class PokemonBase {
  final int id;
  final Pokemon pokemon;
  final PokemonProfile?
  profile; // Hacemos el perfil opcional para carga progresiva

  PokemonBase({required this.id, required this.pokemon, this.profile});
}
