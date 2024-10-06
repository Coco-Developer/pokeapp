import 'package:flutter/material.dart';
import 'details_view.dart'; // Importa la vista de detalles
import '../models/pokemon_model.dart'; // Importa el modelo de Pokémon
import '../widgets/moving_energy.dart'; // Asegúrate de importar el widget de energía en movimiento
import '../services/local_pokemon_data_source.dart'; // Importa el servicio local de Pokémon

class PokemonGridView extends StatelessWidget {
  PokemonGridView({super.key});

  final LocalPokemonDataSource _dataSource = LocalPokemonDataSource(); // Instancia de la fuente de datos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Pokémon',
          style: TextStyle(
            fontFamily: 'Chakra Petch',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE63946),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: MovingEnergy(), // Asegúrate de que no interfiera con otros elementos
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<Pokemon>>(
              future: _dataSource.getPokemons(), // Llama al método de la fuente de datos
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Pokémon found.'));
                }

                final pokemons = snapshot.data!; // Obtén la lista de Pokémon

                return LayoutBuilder(
                  builder: (context, constraints) {
                    int columns = (constraints.maxWidth / 180).floor();
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        childAspectRatio: 0.75, // Ajusta este valor según lo que te funcione mejor
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: pokemons.length,
                      itemBuilder: (context, index) {
                        final pokemon = pokemons[index];
                        return GestureDetector(
                          onTap: () {
                            _navigateToDetails(context, pokemon);
                          },
                          child: Card(
                            elevation: 4,
                            color: Colors.red.withOpacity(0.3), // Color de fondo de las tarjetas con transparencia
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Image.asset(
                                    pokemon.imageUrl,
                                    fit: BoxFit.contain, // Ajusta la imagen al tamaño de la carta
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  pokemon.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Color del texto
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetails(BuildContext context, Pokemon pokemon) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500), // Ajusta la duración de la animación
        pageBuilder: (context, animation, secondaryAnimation) => DetailsView(pokemon: pokemon),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // Comienza desde abajo
          const end = Offset.zero; // Termina en su lugar
          const curve = Curves.easeInOut; // Curva de la animación

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
