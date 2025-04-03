import 'package:cached_network_image/cached_network_image.dart'; // Para cargar imágenes de internet fácilmente
import 'package:flutter/material.dart'; // Incluye los widgets de flutter
import 'package:pokedex/models/pokemonBase.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';

import '../models/pokedex.dart'; // Incluye tu archivo de modelos que creamos previamente

class PokemonListView extends StatefulWidget {
  const PokemonListView({Key? key}) : super(key: key);

  @override
  _PokemonListViewState createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  final List<PokemonBase> _pokemonList = [];
  final PokemonRepository _repository = PokemonRepository();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPokemonList();
  }

  Future<void> _loadPokemonList() async {
    try {
      final pokedex = await _repository.getPokedexData(
        20,
      ); // Limitamos a 20 para eficiencia

      if (pokedex != null) {
        final List<PokemonBase> tempList = [];

        for (var pokemon in pokedex.results) {
          // Extraer el número del Pokémon de la URL
          final urlParts = pokemon.url.split('/');
          final pokemonNumber = int.parse(urlParts[urlParts.length - 2]);

          // Obtener información detallada (incluidas imágenes)
          final profile = await _repository.getPokemonProfileData(
            pokemonNumber,
          );

          // Crear objeto PokemonBase con todos los datos
          final pokemonBase = PokemonBase(
            id: pokemonNumber,
            pokemon: pokemon,
            profile: profile,
          );

          // Añadir a la lista temporal
          tempList.add(pokemonBase);

          // Actualizar el estado para mostrar progresivamente los Pokémon cargados
          setState(() {
            _pokemonList.add(pokemonBase);
          });
        }

        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error al cargar la lista de Pokémon: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<PokemonBase> _createTestData() {
    // Datos de prueba para el preview
    final pokemon1 = Pokemon(name: "bulbasaur", url: "");
    final pokemon2 = Pokemon(name: "charmander", url: "");
    final pokemon3 = Pokemon(name: "squirtle", url: "");

    final sprite1 = Sprite(
      frontDefault:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
      backDefault: "",
    );
    final sprite2 = Sprite(
      frontDefault:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
      backDefault: "",
    );
    final sprite3 = Sprite(
      frontDefault:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png",
      backDefault: "",
    );

    final profile1 = PokemonProfile(sprites: sprite1);
    final profile2 = PokemonProfile(sprites: sprite2);
    final profile3 = PokemonProfile(sprites: sprite3);

    return [
      PokemonBase(id: 1, pokemon: pokemon1, profile: profile1),
      PokemonBase(id: 2, pokemon: pokemon2, profile: profile2),
      PokemonBase(id: 3, pokemon: pokemon3, profile: profile3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body:
          _isLoading && _pokemonList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount:
                    _pokemonList
                        .length, // Agregamos el tamaño de nuestro _pokemonList para la cantidad de items
                itemBuilder: (context, index) {
                  final pokemonBase = _pokemonList[index];
                  return ListTile(a
                    leading:
                        pokemonBase.profile?.sprites.frontDefault != null
                            ? CachedNetworkImage(
                              imageUrl:
                                  pokemonBase.profile!.sprites.frontDefault,
                              placeholder:
                                  (context, url) => const SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: CircularProgressIndicator(),
                                  ),
                              errorWidget:
                                  (context, url, error) =>
                                      const Icon(Icons.error),
                              width: 48,
                              height: 48,
                            )
                            : Container(
                              width: 48,
                              height: 48,
                              color: Colors.grey[300],
                            ),
                    title: Text(
                      pokemonBase.pokemon.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
