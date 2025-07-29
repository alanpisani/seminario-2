import 'elemento.dart';

class GestorElemento {
  final List<ElementoJuego>  _elementos =  [
    ElementoJuego(nombre: "Piedra", img: 'fABkEj9', valor: 0), 
    ElementoJuego(nombre: "Papel", img: 'EplxGmk', valor: 1), 
    ElementoJuego(nombre: "Tijera", img: 'lpKn8zU', valor: 2)
  ];

  List<ElementoJuego> get getElementos => _elementos;

  String obtenerImagen(int eleccion){
    return _elementos[eleccion].img;
  } 

}