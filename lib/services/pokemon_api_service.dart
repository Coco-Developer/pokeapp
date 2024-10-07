// lib/services/pokemon_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_pokemon_model.dart';

class PokemonApiService {
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon";

  Future<List<ApiPokemon>> getPokemons() async {
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
}
