// lib/services/firebase_pokemon_data_source.dart

import 'pokemon_data_source.dart';
import '../models/pokemon_model.dart';

class FirebasePokemonDataSource implements PokemonDataSource {
  @override
  Future<List<Pokemon>> getPokemons() async {
    // Aquí debes implementar la lógica para obtener datos de Firebase
    return []; // Reemplazar con la lógica real
  }
}
