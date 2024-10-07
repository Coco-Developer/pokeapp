import 'package:flutter/material.dart';
import '../models/api_pokemon_model.dart';
import '../widgets/moving_energy.dart'; // Asegúrate de que este widget existe
import 'dart:math'; // Para generar valores aleatorios

class PokemonApiAbilitiesView extends StatefulWidget {
  final ApiPokemon pokemon;

  const PokemonApiAbilitiesView({super.key, required this.pokemon});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonApiAbilitiesViewState createState() => _PokemonApiAbilitiesViewState();
}

class _PokemonApiAbilitiesViewState extends State<PokemonApiAbilitiesView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    // Inicializa el controlador de animación
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Velocidad de la animación
      vsync: this,
    );

    // Crea animaciones para cada habilidad
    _animations = widget.pokemon.abilities.map((ability) {
      double randomLevel = _getRandomAbilityLevel(); // Generar un nivel aleatorio
      return Tween<double>(begin: 0.8, end: randomLevel).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    // Inicia la animación
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Función para generar un valor aleatorio para la barra de habilidades
  double _getRandomAbilityLevel() {
    return Random().nextDouble() * 0.2 + 0.8; // Genera un valor entre 0.8 y 1.0
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.pokemon.name.capitalizeFirst()} Habilidades'), // Capitaliza la primera letra
        backgroundColor: const Color(0xFFE63946),
      ),
      body: Stack(
        children: [
          MovingEnergy(), // Fondo animado
          Container(
            color: Colors.black.withOpacity(0.3), // Fondo negro semitransparente
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Sección de evolución
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                   
                  ),
              
                ),
                const SizedBox(height: 20),
                const Text(
                  'Habilidades:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Chakra Petch',
                  ),
                ),
                const SizedBox(height: 20),
                // Iteramos sobre las habilidades del Pokémon y mostramos cada una
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.pokemon.abilities.length,
                    itemBuilder: (context, index) {
                      final ability = widget.pokemon.abilities[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              ability.name.capitalizeFirst(), // Usar el método de capitalización
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Chakra Petch',
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Barra de progreso para la habilidad
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 15,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: _animations[index],
                                  builder: (context, child) {
                                    return Container(
                                      height: 15,
                                      width: MediaQuery.of(context).size.width * _animations[index].value,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color.fromARGB(255, 0, 255, 51),
                                            const Color.fromARGB(255, 255, 0, 0),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Extensión para capitalizar la primera letra del nombre
extension StringCapitalization on String {
  String capitalizeFirst() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
