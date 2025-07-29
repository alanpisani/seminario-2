import 'package:flutter/material.dart';
import '../../../../controllers/asignacion_controller.dart';
import '../../../../utils/constants/consts_sopa_de_letras.dart';

class GestorLogrosSopaDeLetras {
  final _asignadorDeLogros = AsignacionController();

  void _logroTusPrimerasPalabras(BuildContext context, int respuestasCorrectas){
    if(respuestasCorrectas == cantidadPalabrasEnSopa){
      _asignadorDeLogros.asignarLogro(
        contexto: context, 
        idLogroAAsignar: 20
      );
    }
  }

  void _logroPalabraa(BuildContext context, int segundos){
    if(segundos <= 15){
      _asignadorDeLogros.asignarLogro(
        contexto: context, 
        idLogroAAsignar: 21
      );
    }
  }

  void checkearLogros(BuildContext context, int respuestasCorrectas, int segundos){
    _logroTusPrimerasPalabras(context, respuestasCorrectas);
    _logroPalabraa(context, segundos);
  }
}