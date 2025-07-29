import 'dart:math';

import '../../../../utils/constants/consts_sopa_de_letras.dart';
import '../../../../utils/logic/juegos/sopa_de_letras/casilla_sopa.dart';
import '../../../../utils/logic/juegos/sopa_de_letras/validador_palabras.dart';

class Metepalabras {
  final int _maxIntentos = 200;

  static List<int> _tomarPalabrasAlAzar(){
    List<int> numeros = [];
    int i = 0;

    while(i < cantidadPalabrasEnSopa){
      int numero = Random().nextInt(palabrasParaSopa.length);
      if(!numeros.contains(numero)){
        numeros.add(numero);
        i++;
      }
    }
    return numeros;
  }

  void meterTodasLasPalabras(List<List<CasillaSopa>> matriz){
    List<int> numeros = _tomarPalabrasAlAzar();
    
    for(int i = 0; i<cantidadPalabrasEnSopa;i++){
      _meterPalabra(matriz, palabrasParaSopa[numeros[i]]);
    }
  }

  void _meterPalabra(List<List<CasillaSopa>> matriz, String palabra){
    int numero = Random().nextInt(2);
    
    if(numero == 0){
      bool salioBien = _sePudoMeterPalabraHorizontal(matriz, palabra);
      if(!salioBien){
        salioBien = _sePudoMeterPalabraVertical(matriz, palabra);
      }
    }
    else{
      bool salioBien =  _sePudoMeterPalabraVertical(matriz, palabra);
      if(!salioBien){
        salioBien = _sePudoMeterPalabraHorizontal(matriz, palabra);
      }
    }
  }

  bool _sePudoMeterPalabraHorizontal(List<List<CasillaSopa>> matriz, String palabra){
    int i = 0;
    while(i < _maxIntentos){
      int fila = Random().nextInt(dimensionSopa);
      int columna = Random().nextInt(dimensionSopa);
      if(ValidadorPalabras.sePuedeInsertarHorizontal(matriz, palabra, fila, columna)){
        _insertarPalabraHorizontalmente(matriz, palabra, fila, columna);
        return true;
      }
      i++;
    }
    return false;
  }

  bool _sePudoMeterPalabraVertical(List<List<CasillaSopa>> matriz, String palabra){
    int i = 0;
    while(i < _maxIntentos){
      int fila = Random().nextInt(dimensionSopa);
      int columna = Random().nextInt(dimensionSopa);
      if(ValidadorPalabras.sePuedeInsertarVertical(matriz, palabra, fila, columna)){
        _insertarPalabraVerticalmente(matriz, palabra, fila, columna);
        return true;
      }  
      i++; 
    }
    return false;
  }

  void _insertarPalabraHorizontalmente(List<List<CasillaSopa>> matriz, String palabra, int fila, int columna){
    for(int i = 0; i<palabra.length;i++){
      matriz[fila][columna+i].letra = palabra[i];
    }
  }

  void _insertarPalabraVerticalmente(List<List<CasillaSopa>> matriz, String palabra, int fila, int columna){
    for(int i = 0; i<palabra.length;i++){
      matriz[fila+i][columna].letra = palabra[i];
    }
  }
}