// lib/views/pokemon_api_details_view.dart

import 'package:flutter/material.dart';
import '../models/api_pokemon_model.dart';

class PokemonApiDetailsView extends StatelessWidget {
  final ApiPokemon pokemon;

  const PokemonApiDetailsView({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        backgroundColor: const Color(0xFFE63946),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              'https://img.pokemondb.net/sprites/home/normal/${pokemon.name}.png',
              fit: BoxFit.cover,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Habilidades:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...pokemon.abilities.map((ability) => Text(ability.name)).toList(), // Muestra habilidades
          ],
        ),
      ),
    );
  }
}
