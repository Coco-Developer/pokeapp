import 'package:flutter/material.dart';
import 'package:pokeapp/services/pokemon_api_service.dart'; // Asegúrate de que la ruta sea correcta
import 'package:pokeapp/models/api_pokemon_model.dart';

class PokemonSearchScreen extends StatefulWidget {
  @override
  PokemonSearchScreenState createState() => PokemonSearchScreenState();
}

class PokemonSearchScreenState extends State<PokemonSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PokemonApiService _apiService = PokemonApiService();
  ApiPokemon? _foundPokemon;

  Future<void> _searchPokemon() async {
    final name = _searchController.text.trim();
    if (name.isNotEmpty) {
      try {
        // Cambia esto para usar el método adecuado para obtener un Pokémon por su nombre
        _foundPokemon = await _apiService.getPokemonByName(name);
        setState(() {});
      } catch (e) {
        // Manejar errores, tal vez mostrar un mensaje al usuario
        print("Error buscando Pokémon: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Nombre del Pokémon',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchPokemon,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_foundPokemon != null)
              Column(
                children: [
                  Text('Nombre: ${_foundPokemon!.name}'),
                  Image.network(_foundPokemon!.imageUrl),
                  // Agregar más detalles si es necesario
                ],
              ),
          ],
        ),
      ),
    );
  }
}
