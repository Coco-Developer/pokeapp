// lib/services/pokemon_service.dart

import 'pokemon_data_source.dart';
import '../models/pokemon_model.dart';

class PokemonService {
  final PokemonDataSource dataSource;

  PokemonService(this.dataSource);

  Future<List<Pokemon>> getPokemons() {
    return dataSource.getPokemons();
  }
}
