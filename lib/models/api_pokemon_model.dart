// lib/models/api_pokemon_model.dart

class ApiAbility {
  final String name;

  ApiAbility({required this.name});

  factory ApiAbility.fromJson(Map<String, dynamic> json) {
    return ApiAbility(name: json['ability']['name']);
  }
}

class ApiPokemon {
  final String name;
  final String imageUrl;
  final List<ApiAbility> abilities;

  ApiPokemon({
    required this.name,
    required this.imageUrl,
    required this.abilities,
  });

  factory ApiPokemon.fromJson(Map<String, dynamic> json) {
    var abilityList = json['abilities'] as List;
    List<ApiAbility> abilities = abilityList.map((i) => ApiAbility.fromJson(i)).toList();

    return ApiPokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'], // Asegúrate de tener la URL de la imagen aquí
      abilities: abilities,
    );
  }
}
