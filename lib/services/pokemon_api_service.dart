import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_pokemon_model.dart';

class PokemonApiService {
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon";
  
  // Variable para almacenar Pokémon en caché
  List<ApiPokemon>? _cachedPokemons;

  Future<List<ApiPokemon>> getPokemons() async {
    // Verificamos si ya tenemos Pokémon en caché
    if (_cachedPokemons != null) {
      return _cachedPokemons!;
    }

    // Si no, hacemos la solicitud a la API
    final response = await http.get(Uri.parse('$baseUrl?limit=100'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ApiPokemon> pokemons = [];

      for (var item in data['results']) {
        final pokemonResponse = await http.get(Uri.parse(item['url']));
        if (pokemonResponse.statusCode == 200) {
          final pokemonData = json.decode(pokemonResponse.body);
          pokemons.add(ApiPokemon.fromJson(pokemonData));
        }
      }

      // Almacenamos los Pokémon en caché
      _cachedPokemons = pokemons;
      return pokemons;
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  Future<ApiPokemon> getPokemonByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ApiPokemon.fromJson(data);
    } else {
      throw Exception('Failed to load Pokémon: $name');
    }
  }

  // Método para limpiar la caché (opcional)
  void clearCache() {
    _cachedPokemons = null;
  }
}
