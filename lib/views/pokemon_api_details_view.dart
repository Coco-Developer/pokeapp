import 'package:flutter/material.dart';
import '../models/api_pokemon_model.dart';
import 'pokemon_api_abilities_view.dart';
import '../widgets/moving_energy.dart'; // Widget para fondo animado

class PokemonApiDetailsView extends StatefulWidget {
  final ApiPokemon pokemon;

  const PokemonApiDetailsView({super.key, required this.pokemon});

  @override
  _PokemonApiDetailsViewState createState() => _PokemonApiDetailsViewState();
}

class _PokemonApiDetailsViewState extends State<PokemonApiDetailsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  String displayedName = "";
  late final String fullName;
  final int typingSpeed = 50;

  @override
  void initState() {
    super.initState();

    // Controlador para el Pokémon
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    fullName = widget.pokemon.name.capitalize(); // Capitalizar el nombre
    _controller.forward(); // Iniciar animación
    _typeName(); // Iniciar la animación de tipeo del nombre
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _typeName() async {
    for (int i = 0; i < fullName.length; i++) {
      await Future.delayed(Duration(milliseconds: typingSpeed));
      if (!mounted) return;
      setState(() {
        displayedName = fullName.substring(0, i + 1);
      });
    }
  }

  void _navigateToAbilities(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => PokemonApiAbilitiesView(pokemon: widget.pokemon),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "POKEDEX",
          style: const TextStyle(
            fontFamily: 'Chakra Petch',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE63946),
      ),
      body: Stack(
        children: [
          MovingEnergy(), // Fondo animado
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: ClipOval(
                          child: Image.network(
                            widget.pokemon.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    displayedName,
                    style: const TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  AnimatedPokeball(
                    onTap: () => _navigateToAbilities(context), // Navegar a habilidades aquí
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _navigateToAbilities(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 243, 121, 90),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Ver Habilidades',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para la animación de la Pokébola
class AnimatedPokeball extends StatefulWidget {
  final VoidCallback onTap;

  const AnimatedPokeball({super.key, required this.onTap}); // Agregar un callback

  @override
  _AnimatedPokeballState createState() => _AnimatedPokeballState();
}

class _AnimatedPokeballState extends State<AnimatedPokeball> with SingleTickerProviderStateMixin {
  late AnimationController _ballController;
  late Animation<double> _ballScaleAnimation;

  @override
  void initState() {
    super.initState();

    _ballController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _ballScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _ballController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _ballController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _ballScaleAnimation,
      child: GestureDetector(
        onTap: () {
          _ballController.forward().then((_) {
            Future.delayed(const Duration(milliseconds: 200), () {
              _ballController.reverse().then((_) {
                widget.onTap(); // Llamar al callback de navegación
              });
            });
          });
        },
        child: Image.asset(
          'lib/assets/images/botonball.png',
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}

// Extensión para capitalizar la primera letra del nombre
extension StringCapitalization on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
