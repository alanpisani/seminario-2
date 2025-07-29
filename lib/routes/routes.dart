import 'package:flutter/material.dart';
import '../screens/juegos/lluvia_de_palabras.dart';
import '../screens/juegos/sopa_de_letras.dart';
import '../screens/ranking/ranking_main_screen.dart';
import '../screens/intro.dart';
import '../screens/juegos/adivinar_numero.dart';
import '../screens/juegos/memoria.dart';
import '../screens/juegos/piedra_papel_tijera.dart';
import '../screens/juegos/suma_resta.dart';
import '../screens/juegos/tateti.dart';
import '../screens/menu/logros_screen.dart';
import '../screens/menu/page_view_menu_juegos.dart';
import '../screens/usuario/menu_usuario.dart';


Map <String, WidgetBuilder> routes = {
  "/intro": (context) => const Intro(),
  "/": (context) => const MenuUsuario(),
  '/home': (context) => const PageViewMenuJuegos(),
  "/logros": (context) => const LogrosScreen(),
  "/ranking": (context) => const RankingMainScreen(),
  "/piedra_papel_tijera": (context) => const PiedraPapelTijera(),
  "/adivina_el_numero": (context) => const AdivinarNumero(),
  "/suma_resta": (context) => const SumaResta(),
  "/memoria": (context) => const Memoria(),
  "/tateti": (context) => const Tateti(),
  "/sopa_de_letras": (context) => const SopaDeLetras(),
  "/lluvia_de_palabras": (context) => const LluviaDePalabras(),
  
};