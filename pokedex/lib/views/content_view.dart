import 'package:cached_network_image/cached_network_image.dart'; // Para cargar imágenes de internet fácilmente
import 'package:flutter/material.dart'; // Incluye los widgets de flutter
import 'package:pokedex/models/pokemonBase.dart';

import '../models/pokedex.dart'; // Incluye tu archivo de modelos que creamos previamente

class ContentView extends StatefulWidget {
  final List<PokemonBase>?
  pokemonList; // Crear el arreglo que contiene la lista de pokemon

  const ContentView({Key? key, this.pokemonList}) : super(key: key);

  @override
  _ContentViewState createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  late List<PokemonBase> _pokemonList;

  @override
  void initState() {
    super.initState();
    // Si recibimos una lista, la usamos; de lo contrario, creamos datos de prueba
    _pokemonList = widget.pokemonList ?? _createTestData();
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
      body: ListView.builder(
        itemCount:
            _pokemonList
                .length, // Agregamos el tamaño de nuestro _pokemonList para la cantidad de items
        itemBuilder: (context, index) {
          final pokemonBase = _pokemonList[index];
          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: pokemonBase.profile.sprites.frontDefault,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 80,
              height: 80,
            ),
            title: Text(
              pokemonBase.pokemon.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
