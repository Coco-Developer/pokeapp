// lib/main.dart

import 'package:flutter/material.dart';
import 'views/home_view.dart';
import 'services/local_pokemon_data_source.dart';
import 'services/pokemon_service.dart';


void main() {
  runApp(const PokeApp());
}

class PokeApp extends StatelessWidget {
  const PokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POKEMON APP',
      theme: _buildTheme(),
      home: const HomeView(),
      debugShowCheckedModeBanner: false, // Elimina la etiqueta de debug
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      primaryColor: const Color(0xFFE63946), // Rojo Pokémon
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color(0xFFF1FAEE), // Blanco suave
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Chakra Petch',
          fontWeight: FontWeight.bold,
          fontSize: 32.0,
          color: const Color(0xFFE63946), // Color del texto
        ),
        displayMedium: TextStyle(
          fontFamily: 'Chakra Petch',
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          color: const Color(0xFFE63946),
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Chakra Petch',
          fontSize: 16.0,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Chakra Petch',
          fontSize: 14.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Ejemplo de uso del PokemonService (opcional)
class PokemonExample {
  final PokemonService _pokemonService;

  PokemonExample() : _pokemonService = PokemonService(LocalPokemonDataSource());

  void loadPokemons() {
    _pokemonService.getPokemons().then((pokemons) {
      // Procesar lista de Pokémon
      print(pokemons.length);
    });
  }
}
