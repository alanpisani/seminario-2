import 'package:flutter/material.dart';

const Map<String, String> descripcionHome = {
  "Jugar": "Elegí entre un catálogo de divertidos juegos. Enfrenta los desafios y superá todos los retos",
  "Logros": "Cumplí los desafíos. Demostrá lo buen jugador que sos completando todos los logros",
  "Ranking": "Demostrá tu valía. Ganate el primer puesto en todos los juegos",
  "Salir de la app": "Cerrar la app. ¡Volvé cuando puedas! Los desafíos te esperan"
};

List<String> titulosHome = descripcionHome.keys.toList();
const List<String> imagenesHome = ['jugar.jpg', 'logros.jpg', 'ranking.jpg', 'jugar.jpg'];
const List<Color> coloresHome = [Colors.red, Colors.purple, Colors.cyan, Colors.indigo];
const List<String> rutasHome = ["/juegos", "/logros", "/ranking", "/salir"];