// lib/services/local_pokemon_data_source.dart

import 'pokemon_data_source.dart';
import '../models/pokemon_model.dart';

class LocalPokemonDataSource implements PokemonDataSource {
  @override
  Future<List<Pokemon>> getPokemons() async {
    return [
 
      Pokemon(
        name: 'Pikachu',
        imageUrl: 'lib/assets/images/pikachu.png',
        description:
            'Un Pokémon eléctrico muy popular. Es conocido por su poderoso rayo y su adorable apariencia.',
        abilities: [
          Ability(name: 'Electricidad estática', level: 75),
          Ability(name: 'Agilidad', level: 60),
          Ability(name: 'Rayo', level: 80),
          Ability(name: 'Impactrueno', level: 85),
          Ability(name: 'Chispazo', level: 70),
        ],
        evolution: 'Raichu',
        gpsLocation: 'Zonas urbanas y parques',
      ),
      Pokemon(
        name: 'Charmander',
        imageUrl: 'lib/assets/images/charmander.png',
        description:
            'Un Pokémon de tipo fuego valiente. Tiene una llama en la punta de su cola que representa su energía vital.',
        abilities: [
          Ability(name: 'Llamarada', level: 70),
          Ability(name: 'Garra Dragón', level: 65),
          Ability(name: 'Lanzallamas', level: 85),
          Ability(name: 'Ascuas', level: 75),
          Ability(name: 'Fuego Fatuo', level: 80),
        ],
        evolution: 'Charizard',
        gpsLocation: 'Zonas volcánicas y desiertos',
      ),
      Pokemon(
        name: 'Squirtle',
        imageUrl: 'lib/assets/images/squirtle.png',
        description:
            'Un Pokémon de tipo agua conocido por su caparazón. Squirtle es un excelente nadador y puede lanzar chorros de agua con gran precisión.',
        abilities: [
          Ability(name: 'Chorro de agua', level: 70),
          Ability(name: 'Burbuja', level: 60),
          Ability(name: 'Rayo Hielo', level: 75),
          Ability(name: 'Aguacero', level: 80),
          Ability(name: 'Hidrobomba', level: 85),
        ],
        evolution: 'Blastoise',
        gpsLocation: 'Cerca de cuerpos de agua como ríos y lagos',
      ),
      Pokemon(
        name: 'Bulbasaur',
        imageUrl: 'lib/assets/images/bulbasaur.png',
        description:
            'Un Pokémon de tipo planta conocido por su bulbo. Tiene habilidades especiales relacionadas con la fotosíntesis y el crecimiento de plantas.',
        abilities: [
          Ability(name: 'Latigazo', level: 65),
          Ability(name: 'Solar', level: 80),
          Ability(name: 'Dormir', level: 50),
          Ability(name: 'Rayo Solar', level: 90),
          Ability(name: 'Polvo Fértil', level: 55),
        ],
        evolution: 'Venusaur',
        gpsLocation: 'Zonas boscosas y jardines',
      ),
      Pokemon(
        name: 'Mewtwo',
        imageUrl: 'lib/assets/images/mewtwo.png',
        description:
            'Un Pokémon psíquico legendario conocido por su gran poder. Fue creado a partir del ADN de Mew.',
        abilities: [
          Ability(name: 'Presión', level: 100),
          Ability(name: 'Barrera', level: 95),
          Ability(name: 'Confusión', level: 85),
          Ability(name: 'Psíquico', level: 100),
        ],
        evolution: 'No tiene',
        gpsLocation: 'Laboratorios de investigación y cuevas',
      ),
      Pokemon(
        name: 'Cubone',
        imageUrl: 'lib/assets/images/cubone.png',
        description:
            'Un Pokémon de tipo tierra conocido por llevar un cráneo en la cabeza. Es famoso por su triste historia.',
        abilities: [
          Ability(name: 'Cabeza de roca', level: 50),
          Ability(name: 'Pico de rayo', level: 40),
          Ability(name: 'Golpe cabeza', level: 65),
          Ability(name: 'Furia', level: 55),
        ],
        evolution: 'Marowak',
        gpsLocation: 'Zonas desérticas y cuevas',
      ),
      Pokemon(
        name: 'Jigglypuff',
        imageUrl: 'lib/assets/images/jigglypuff.png',
        description:
            'Un Pokémon de tipo normal conocido por su canto soporífero. Puede hacer que cualquiera se duerma con su canción.',
        abilities: [
          Ability(name: 'Canto', level: 70),
          Ability(name: 'Desenrollar', level: 60),
          Ability(name: 'Ataque doble', level: 75),
          Ability(name: 'Bofetón lodo', level: 65),
        ],
        evolution: 'Wigglytuff',
        gpsLocation: 'Praderas y zonas boscosas',
      ),
      Pokemon(
        name: 'Onix',
        imageUrl: 'lib/assets/images/onix.png',
        description:
            'Un Pokémon de tipo roca y tierra. Onix es masivo y se mueve bajo tierra con una velocidad sorprendente para su tamaño.',
        abilities: [
          Ability(name: 'Excavar', level: 85),
          Ability(name: 'Cuerpo pesado', level: 90),
          Ability(name: 'Lanzarrocas', level: 75),
          Ability(name: 'Cola férrea', level: 80),
        ],
        evolution: 'Steelix',
        gpsLocation: 'Montañas y cuevas subterráneas',
      ),
      Pokemon(
        name: 'Gengar',
        imageUrl: 'lib/assets/images/gengar.png',
        description:
            'Un Pokémon de tipo fantasma conocido por ser travieso y jugar malas pasadas a las personas en la oscuridad.',
        abilities: [
          Ability(name: 'Maldición', level: 90),
          Ability(name: 'Bola sombra', level: 85),
          Ability(name: 'Lengüetazo', level: 70),
          Ability(name: 'Rayo', level: 80),
        ],
        evolution: 'No tiene',
        gpsLocation: 'Cementerios y lugares oscuros',
      ),
      Pokemon(
        name: 'Lapras',
        imageUrl: 'lib/assets/images/lapras.png',
        description:
            'Un Pokémon de tipo agua y hielo, conocido por su naturaleza amigable y su capacidad para transportar personas a través del agua.',
        abilities: [
          Ability(name: 'Canto', level: 65),
          Ability(name: 'Rayo hielo', level: 90),
          Ability(name: 'Surf', level: 85),
          Ability(name: 'Hidrobomba', level: 95),
        ],
        evolution: 'No tiene',
        gpsLocation: 'Océanos y grandes lagos',
      ),
      Pokemon(
        name: 'Pidgeot',
        imageUrl: 'lib/assets/images/pidgeot.png',
        description:
            'Un Pokémon de tipo volador, conocido por su velocidad y capacidad para volar a grandes alturas.',
        abilities: [
          Ability(name: 'Ataque Ala', level: 70),
          Ability(name: 'Vendaval', level: 85),
          Ability(name: 'Remolino', level: 75),
          Ability(name: 'Aerochorro', level: 90),
        ],
        evolution: 'Pidgeotto',
        gpsLocation: 'Cielos abiertos y bosques',
      ),
      Pokemon(
        name: 'Mew',
        imageUrl: 'lib/assets/images/mew.png',
        description:
            'Un Pokémon legendario de tipo psíquico, conocido por su habilidad de aprender casi cualquier movimiento.',
        abilities: [
          Ability(name: 'Psíquico', level: 95),
          Ability(name: 'Esfera Aural', level: 85),
          Ability(name: 'Campo de Fuerza', level: 80),
          Ability(name: 'Teletransporte', level: 70),
        ],
        evolution: 'No tiene evolución',
        gpsLocation: 'Lugares míticos y secretos',
      ),
      Pokemon(
        name: 'Snorlax',
        imageUrl: 'lib/assets/images/snorlax.png',
        description:
            'Un Pokémon de tipo normal, conocido por su inmenso tamaño y su constante apetito.',
        abilities: [
          Ability(name: 'Descanso', level: 85),
          Ability(name: 'Golpe Cuerpo', level: 90),
          Ability(name: 'Terremoto', level: 80),
          Ability(name: 'Gigaimpacto', level: 95),
        ],
        evolution: 'No tiene evolución',
        gpsLocation: 'Bosques y praderas',
      ),
      Pokemon(
        name: 'Rattata',
        imageUrl: 'lib/assets/images/rattata.png',
        description:
            'Un Pokémon de tipo normal, conocido por su velocidad y su capacidad para roer casi cualquier cosa.',
        abilities: [
          Ability(name: 'Ataque Rápido', level: 60),
          Ability(name: 'Mordisco', level: 70),
          Ability(name: 'Hipercolmillo', level: 65),
          Ability(name: 'Placaje', level: 50),
        ],
        evolution: 'Raticate',
        gpsLocation: 'Zonas urbanas y campos',
      ),
      Pokemon(
        name: 'Dragonite',
        imageUrl: 'lib/assets/images/dragonite.png',
        description:
            'Un Pokémon de tipo dragón/volador, conocido por su amabilidad y su inmenso poder en batalla.',
        abilities: [
          Ability(name: 'Puño Fuego', level: 85),
          Ability(name: 'Cometa Draco', level: 90),
          Ability(name: 'Hiperrayo', level: 95),
          Ability(name: 'Vuelo', level: 80),
        ],
        evolution: 'Dragonair',
        gpsLocation: 'Islas remotas y cielos despejados',
      ),
      Pokemon(
        name: 'Magneton',
        imageUrl: 'lib/assets/images/magneton.png',
        description:
            'Un Pokémon de tipo eléctrico/acero, conocido por su control de campos magnéticos y electricidad.',
        abilities: [
          Ability(name: 'Rayo', level: 85),
          Ability(name: 'Cañón Zap', level: 80),
          Ability(name: 'Chispazo', level: 75),
          Ability(name: 'Onda Trueno', level: 70),
        ],
        evolution: 'Magnemite',
        gpsLocation: 'Áreas industriales y zonas magnéticas',
      ),
      Pokemon(
        name: 'Alakazam',
        imageUrl: 'lib/assets/images/alakazam.png',
        description:
            'Un Pokémon de tipo psíquico, conocido por su increíble poder mental y telequinesis.',
        abilities: [
          Ability(name: 'Confusión', level: 75),
          Ability(name: 'Psíquico', level: 90),
          Ability(name: 'Premonición', level: 85),
          Ability(name: 'Telequinesis', level: 80),
        ],
        evolution: 'Kadabra',
        gpsLocation: 'Zonas urbanas y laboratorios',
      ),
      Pokemon(
        name: 'Golem',
        imageUrl: 'lib/assets/images/golem.png',
        description:
            'Un Pokémon de tipo roca/tierra, conocido por su resistente caparazón de roca y su fuerza bruta.',
        abilities: [
          Ability(name: 'Lanzarrocas', level: 75),
          Ability(name: 'Terremoto', level: 85),
          Ability(name: 'Autodestrucción', level: 95),
          Ability(name: 'Avalancha', level: 80),
        ],
        evolution: 'Graveler',
        gpsLocation: 'Montañas y cuevas',
      ),
      Pokemon(
        name: 'Vaporeon',
        imageUrl: 'lib/assets/images/vaporeon.png',
        description:
            'Un Pokémon de tipo agua, conocido por su habilidad para fundirse con el agua y moverse sin ser detectado.',
        abilities: [
          Ability(name: 'Hidrobomba', level: 85),
          Ability(name: 'Aqua Jet', level: 80),
          Ability(name: 'Velo Agua', level: 70),
          Ability(name: 'Rayo Hielo', level: 90),
        ],
        evolution: 'Eevee',
        gpsLocation: 'Ríos y lagos',
      ),
      Pokemon(
        name: 'Hitmonlee',
        imageUrl: 'lib/assets/images/hitmonlee.png',
        description:
            'Un Pokémon de tipo lucha, conocido por sus poderosas patadas y su elasticidad en las piernas.',
        abilities: [
          Ability(name: 'Patada Salto', level: 85),
          Ability(name: 'Golpe Karate', level: 75),
          Ability(name: 'Patada Baja', level: 80),
          Ability(name: 'Patada Ígnea', level: 90),
        ],
        evolution: 'Tyrogue',
        gpsLocation: 'Montañas y dojos de entrenamiento',
      ),
    ];
  }
}
