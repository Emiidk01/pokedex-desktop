import 'package:flutter/material.dart';
import 'package:pokedex/viewmodels/pokemon_viewmodel.dart';
import 'package:pokedex/views/content_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const PokedexApp(),
  ); // runApp corre la instancia de nuestra aplicación principal
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({Key? key})
    : super(
        key: key,
      ); // super(key: key) → Pasa la clave (key) al constructor de StatelessWidget (opcional, útil en listas para identificar widgets únicos).

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonListViewModel()),
      ],
      child: MaterialApp(
        title: 'Pokedex App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: const PokemonListView(),
      ),
    );
  }
}
