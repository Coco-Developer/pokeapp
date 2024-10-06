// lib/models/pokemon_model.dart

class Ability {
  final String name;
  final int level;

  Ability({required this.name, required this.level});
}

class Pokemon {
  final String name;
  final String imageUrl;
  final String description;
  final List<Ability> abilities;
  final String evolution;
  final String gpsLocation;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.abilities,
    required this.evolution,
    required this.gpsLocation,
  });

  // Método para crear un Pokémon desde Firestore
  // static Pokemon fromFirestore(DocumentSnapshot doc) {
  //   // Aquí puedes agregar la lógica para crear un Pokémon desde los datos de Firestore
  // }
}
