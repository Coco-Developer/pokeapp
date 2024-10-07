import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';
import 'abilities_view.dart';
import '../widgets/moving_energy.dart';

class DetailsView extends StatefulWidget {
  final Pokemon pokemon;

  const DetailsView({super.key, required this.pokemon});

  @override
  DetailsViewState createState() => DetailsViewState();
}

class DetailsViewState extends State<DetailsView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  
  String displayedDescription = ""; // Texto para animación de máquina de escribir
  late final String fullDescription; // Texto completo de la descripción
  final int typingSpeed = 10; // Velocidad de escritura en milisegundos

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    fullDescription = widget.pokemon.description;
    _typeDescription(); // Iniciar la animación de escritura de la descripción
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Animar el texto de la descripción sin Timer
  Future<void> _typeDescription() async {
    for (int i = 0; i < fullDescription.length; i++) {
      await Future.delayed(Duration(milliseconds: typingSpeed));

      // Solo actualizar el estado si el widget está montado
      if (!mounted) return;

      setState(() {
        displayedDescription = fullDescription.substring(0, i + 1);
      });
    }
  }

  void _navigateToAbilities(BuildContext context) {
    _controller.forward().then((_) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => AbilitiesView(pokemon: widget.pokemon),
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
      ).then((_) {
        _controller.reset();
        setState(() {
          displayedDescription = ""; // Limpiar el texto mostrado
        });
        _typeDescription(); // Reiniciar la animación de tipeo
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POKEDEX',
          style: TextStyle(
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
          MovingEnergy(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 20 : 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Imagen del Pokémon
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                        widget.pokemon.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Nombre del Pokémon
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.pokemon.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Descripción del Pokémon
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        displayedDescription,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Botón que lleva a la vista de habilidades
                    GestureDetector(
                      onTap: () {
                        _navigateToAbilities(context);
                      },
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _opacityAnimation.value,
                            child: Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'lib/assets/images/botonball.png',
                                    height: 100,
                                    width: 100,
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      _navigateToAbilities(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 227, 247, 0),
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        'Ver Habilidades',
                                        style: const TextStyle(
                                          fontFamily: 'Chakra Petch',
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 35, 35, 25),
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
