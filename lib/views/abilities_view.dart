import 'package:flutter/material.dart';
import '../models/pokemon_model.dart'; // Importa el modelo de Pokémon
import '../widgets/moving_energy.dart'; // Asegúrate de que este widget existe

class AbilitiesView extends StatefulWidget {
  final Pokemon pokemon;

  const AbilitiesView({super.key, required this.pokemon});

  @override
  AbilitiesViewState createState() => AbilitiesViewState();
}

class AbilitiesViewState extends State<AbilitiesView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    // Inicializa el controlador de animación
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Crea animaciones para cada habilidad
    _animations = widget.pokemon.abilities.map((ability) {
      return Tween<double>(begin: 0, end: ability.level / 100).animate(
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

  void _openMaps() {
    final url = 'https://www.google.com/maps/search/?api=1&query=${widget.pokemon.gpsLocation}';
    // Aquí podrías usar un paquete para abrir el navegador o la app de mapas
    print('Abriendo GPS: $url'); // Aquí se usa print como ejemplo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Habilidades de ${widget.pokemon.name}',style: TextStyle(
            fontFamily: 'Chakra Petch',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFFE63946),
      ),

      body: Stack(
        children: [
          // Imagen de fondo del Pokémon
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.pokemon.imageUrl), // Imagen del Pokémon
                fit: BoxFit.cover,
              ),
            ),
          ),
          MovingEnergy(), // Efecto de energía en movimiento
          Container(
            color: Colors.black.withOpacity(0.3), // Fondo negro transparente
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Muestra la evolución del Pokémon con fondo negro
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Evolución: ${widget.pokemon.evolution}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Chakra Petch',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Botón para GPS con ícono
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _openMaps,
                      child: const Text(
                        'Ubicación Habitual',
                        style: TextStyle(
                          fontFamily: 'Chakra Petch',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.5), 
                        // Fondo del botón
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      ),
                    ),
                  ],
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
                              ability.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Chakra Petch',
                              ),
                            ),
                            const SizedBox(height: 5),
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
                                          colors: [const Color.fromARGB(255, 0, 255, 51), const Color.fromARGB(255, 255, 0, 0)],
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
