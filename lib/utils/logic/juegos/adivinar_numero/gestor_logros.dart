import 'package:flutter/material.dart';
import '../../../../controllers/asignacion_controller.dart';

class GestorLogrosAdivinarNumero{
  final _asignacionController = AsignacionController();
  int _contador = 0;

  void incrementarContador(){
    _contador++;
  }

  void _logroTuveFe(int num, int random, BuildContext context)async{
    if (_contador == 1 && num == random){
      _asignacionController.asignarLogro(
        contexto: context, 
        idLogroAAsignar: 7
      );
    }
  }

  void _logroUstedNoAprendeVerdad(int numeroElegido, BuildContext context)async{
    if(_ingresoCualquierCosa(numeroElegido)){
      _asignacionController.asignarLogro(
          contexto: context, 
          idLogroAAsignar: 8
      );
    }
  }

  bool _ingresoCualquierCosa(int numeroElegido){
    return numeroElegido < 1 || numeroElegido > 100;
  }

  void checkearLogros(int numeroElegido, int random, BuildContext context)async{
    _logroTuveFe(numeroElegido, random, context);
    _logroUstedNoAprendeVerdad(numeroElegido, context);
  }
}