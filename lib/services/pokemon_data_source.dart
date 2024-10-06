// lib/services/pokemon_data_source.dart

import '../models/pokemon_model.dart';

abstract class PokemonDataSource {
  Future<List<Pokemon>> getPokemons();
}
