// lib/services/pokemon_service.dart

import 'pokemon_data_source.dart';
import '../models/pokemon_model.dart';

class PokemonService {
  final PokemonDataSource dataSource;

  PokemonService(this.dataSource);

  Future<List<Pokemon>> getPokemons() {
    return dataSource.getPokemons(); // Para obtener Pokémon desde la fuente de datos
  }
  
  // Si necesitas un método específico para obtener desde la API:
  Future<List<Pokemon>> getPokemonsFromApi() {
    return dataSource.getPokemons(); // Esto puede ser el mismo método
  }
}
