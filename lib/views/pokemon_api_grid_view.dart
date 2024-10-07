import 'package:flutter/material.dart';
import '../services/pokemon_api_service.dart';
import '../models/api_pokemon_model.dart';
import 'pokemon_api_details_view.dart';
import '../widgets/moving_energy.dart';

class PokemonApiGridView extends StatefulWidget {
  const PokemonApiGridView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonApiGridViewState createState() => _PokemonApiGridViewState();
}

class _PokemonApiGridViewState extends State<PokemonApiGridView> {
  List<ApiPokemon> _pokemons = [];
  List<ApiPokemon> _filteredPokemons = [];
  bool _showSearchBar = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPokemons();
  }

  Future<void> _loadPokemons() async {
    try {
      final pokemons = await PokemonApiService().getPokemons();
      setState(() {
        _pokemons = pokemons;
        _filteredPokemons = pokemons;
        _isLoading = false; // Detiene el estado de carga
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Detiene el estado de carga incluso en caso de error
      });
    }
  }

  void _filterPokemons(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredPokemons = _pokemons;
      });
    } else {
      setState(() {
        _filteredPokemons = _pokemons
            .where((pokemon) => pokemon.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokédex API',
          style: TextStyle(
            fontFamily: 'Chakra Petch',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFFE63946),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
              });
            },
          ),
        ],
        bottom: _showSearchBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    onChanged: _filterPokemons,
                    decoration: InputDecoration(
                      hintText: 'Buscar Pokémon...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFE63946), // Fondo rojo
                      hintStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                    ),
                    style: const TextStyle(color: Colors.black), // Texto negro
                  ),
                ),
              )
            : null,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: MovingEnergy(),
          ),
          _isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text(
                        "Cargando lista...",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                )
              : _filteredPokemons.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron Pokémon',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: _filteredPokemons.length,
                        itemBuilder: (context, index) {
                          final pokemon = _filteredPokemons[index];
                          return GestureDetector(
                            onTap: () {
                              _navigateToDetails(context, pokemon);
                            },
                            child: Card(
                              elevation: 4,
                              color: Colors.red.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      pokemon.imageUrl,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    capitalize(pokemon.name), // Aquí se aplica el método capitalize
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }

  void _navigateToDetails(BuildContext context, ApiPokemon pokemon) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            PokemonApiDetailsView(pokemon: pokemon),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // Animación desde abajo
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }
}
