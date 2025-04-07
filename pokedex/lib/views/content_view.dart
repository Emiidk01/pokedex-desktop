import 'package:cached_network_image/cached_network_image.dart'; // Para cargar imágenes de internet fácilmente
import 'package:flutter/material.dart'; // Incluye los widgets de flutter
import 'package:pokedex/data/models/pokemonBase.dart';
import 'package:pokedex/data/repositories/pokemon_repository.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pokemon_viewmodel.dart';

import '../data/models/pokedex.dart'; // Incluye tu archivo de modelos que creamos previamente

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
    // Cargar los datos cuando el widget se inicializa
    Future.microtask(
      () =>
          Provider.of<PokemonListViewModel>(
            context,
            listen: false,
          ).loadPokemonList(),
    );
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
      body: Consumer<PokemonListViewModel>(
        builder: (context, viewModel, child) {
          // Mostrar indicador de carga si no hay datos
          if (viewModel.isLoading && viewModel.pokemonList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Mostrar la lista de Pokémon
          return ListView.builder(
            itemCount: viewModel.pokemonList.length,
            itemBuilder: (context, index) {
              final pokemonBase = viewModel.pokemonList[index];
              return ListTile(
                leading:
                    pokemonBase.profile?.sprites.frontDefault != null
                        ? CachedNetworkImage(
                          imageUrl: pokemonBase.profile!.sprites.frontDefault,
                          placeholder:
                              (context, url) => const SizedBox(
                                width: 48,
                                height: 48,
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
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
                onTap: () {
                  // Navegación para una futura vista de detalle
                },
              );
            },
          );
        },
      ),
    );
  }
}
