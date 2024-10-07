import 'package:flutter/material.dart';
import '../services/pokemon_api_service.dart'; // Asegúrate de que esto está correcto
import '../models/api_pokemon_model.dart';

class PokemonApiGridView extends StatelessWidget {
  const PokemonApiGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex API'),
        backgroundColor: const Color(0xFFE63946),
      ),
      body: FutureBuilder<List<ApiPokemon>>(
        future: PokemonApiService().getPokemons(), // Cargar los Pokémon desde la API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Pokémon found'));
          } else {
            final pokemons = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Image.network(pokemons[index].imageUrl), // Mostrar la imagen del Pokémon
                      Text(pokemons[index].name), // Muestra el nombre del Pokémon
                      // Aquí puedes agregar más información como habilidades
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
