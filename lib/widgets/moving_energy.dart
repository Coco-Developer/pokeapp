import 'dart:math';
import 'package:flutter/material.dart';

class MovingEnergy extends StatefulWidget {
  const MovingEnergy({super.key});

  @override
  MovingEnergyState createState() => MovingEnergyState();
}

class MovingEnergyState extends State<MovingEnergy> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> particles = []; // Lista para las partículas

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Velocidad de la animación
      vsync: this,
    )..repeat();

    // Inicializa las partículas
    _initializeParticles();
  }

  void _initializeParticles() {
    for (int i = 0; i < 100; i++) { // Número de partículas
      particles.add(Particle());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene el tamaño de la pantalla
    Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.5),
                    const Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                ),
              ),
              child: Opacity(
                opacity: _controller.value, // Cambia la opacidad
                child: child,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent, // Fondo transparente
            ),
          ),
        ),
        // Mostrar las partículas usando el tamaño de la pantalla
        ...particles.map((particle) => particle.buildParticle(_controller, screenSize)),
      ],
    );
  }
}

class Particle {
  double initialX; // Posición inicial en X (no es final)
  double y; // Posición en Y
  final double size; // Tamaño de la partícula

  // Constructor que genera posiciones aleatorias
  Particle()
      : initialX = Random().nextDouble() * 400, // Genera un X aleatorio
        y = Random().nextDouble() * 800 + 600, // Comienza fuera de la pantalla
        size = Random().nextDouble() * 3 + 2; // Tamaño más pequeño

  // Método para construir la partícula
  Widget buildParticle(AnimationController controller, Size screenSize) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Calcula la nueva posición de la partícula
        double newY = y - (controller.value * (screenSize.height + 100)); // Movimiento más rápido hacia arriba
        if (newY < -10) {
          // Reiniciar la partícula fuera de la pantalla
          newY = screenSize.height; 
          initialX = Random().nextDouble() * screenSize.width; // Reiniciar posición X aleatoria
        }

        return Positioned(
          left: initialX,
          top: newY,
          child: Opacity(
            opacity: 1 - controller.value, // Cambia la opacidad
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 224, 255, 137).withOpacity(0.999), // Color brillante de la partícula
              ),
            ),
          ),
        );
      },
    );
  }
}
