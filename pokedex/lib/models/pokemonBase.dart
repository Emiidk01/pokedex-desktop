import 'package:pokedex/models/pokedex.dart';

class PokemonBase {
  final int id;
  final Pokemon pokemon;
  final PokemonProfile profile;

  PokemonBase({required this.id, required this.pokemon, required this.profile});
}
