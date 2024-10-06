import 'package:flutter/material.dart';
import 'grid_view.dart'; // Importa la vista de la cuadrícula de Pokémon
import '../widgets/footer.dart'; // Importa tu footer desde la carpeta widgets

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  double _scalePokedex = 1.0; // Para la Pokébola
  double _scaleText = 1.0; // Para el texto de instrucciones
  String displayedText = ""; // Texto para animación de máquina de escribir
  final String fullText = "Presiona el Pokédex"; // Texto completo
  final int typingSpeed = 100; // Velocidad de escritura en milisegundos

  @override
  void initState() {
    super.initState();
    _typeText(); // Inicia la animación de escritura al crear la vista
  }

  // Función para animar el texto como una máquina de escribir
  void _typeText() async {
    for (int i = 0; i < fullText.length; i++) {
      await Future.delayed(Duration(milliseconds: typingSpeed));
      setState(() {
        displayedText += fullText[i]; // Agrega una letra cada vez
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Para que el contenido esté centrado y el footer abajo
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 65, 98, 147),
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/pokeball.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2),
                    BlendMode.dstATop,
                  ),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      '¡Bienvenido al Mundo Pokémon!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Chakra Petch',
                        fontSize: 26, // Tamaño de fuente aumentado
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // Aquí se añade una animación para la transición
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => PokemonGridView(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0); // Desplazamiento de la derecha
                              const end = Offset.zero; // Posición final
                              const curve = Curves.easeInOut; // Curva de la animación

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      onTapDown: (_) {
                        setState(() {
                          _scalePokedex = 0.9; // Reduce el tamaño al tocar
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _scalePokedex = 1.0; // Vuelve al tamaño original
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          _scalePokedex = 1.0; // Vuelve al tamaño original si el toque se cancela
                        });
                      },
                      child: Transform.scale(
                        scale: _scalePokedex,
                        child: Image.asset(
                          'lib/assets/images/pokedex.png', // Cambia a tu imagen
                          width: 200, // Cambia el tamaño según sea necesario
                          height: 200, // Cambia el tamaño según sea necesario
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Añade el texto animado aquí
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black54, // Fondo semi-transparente para sombra
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            _scaleText = 0.9; // Reduce el tamaño al tocar
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            _scaleText = 1.0; // Vuelve al tamaño original
                          });
                        },
                        onTapCancel: () {
                          setState(() {
                            _scaleText = 1.0; // Vuelve al tamaño original si el toque se cancela
                          });
                        },
                        child: Transform.scale(
                          scale: _scaleText,
                          child: Text(
                            displayedText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Chakra Petch',
                              fontSize: 18, // Tamaño de fuente ajustado
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Footer(), // Inserta el footer aquí
        ],
      ),
    );
  }
}
