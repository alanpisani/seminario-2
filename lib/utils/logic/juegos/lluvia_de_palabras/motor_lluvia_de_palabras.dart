import 'dart:math';

import '../../../../utils/constants/consts_lluvia_de_palabras.dart';

class MotorLluviaDePalabras{
  final List<String> categoriasLluviaDePalabras = categoriasYSusPalabras.keys.toList();
  List<String> listaPalabrasMetidas = [];
  
  String normalizarPalabra(String palabra){
    return palabra.trim().toLowerCase();
  }

  void limpiarListPalabrasMetidas(){
    listaPalabrasMetidas = [];
  }

  bool esCorrecta(String palabra, List<String> lista){
    return lista.contains(palabra);
  }

  String retornarRespuesta(String palabra, List<String> lista){
  
    if(listaPalabrasMetidas.contains(palabra)){
      return "$palabra ya había sido ingresada antes!";
    }
    else if(lista.contains(palabra)){
      listaPalabrasMetidas.add(palabra);
      return "Bien! $palabra se encuentra en la lista!";
      
    }
    else{
      return "$palabra NO se encuentra en la lista!";
    }
  }

  int cambiarCategoriaAlAzar(int categoriaAlAzar){
    int categoriaNueva = Random().nextInt(categoriasYSusPalabras.length);

    while(categoriaNueva == categoriaAlAzar){
      categoriaNueva = Random().nextInt(categoriasYSusPalabras.length);
    }

    return categoriaNueva;
  }

}