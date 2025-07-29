import 'package:flutter/material.dart';
import '../../../../controllers/asignacion_controller.dart';

class GestorLogrosSumaResta{
  final _asignacionController = AsignacionController();
  int contErroneasConsecutivas = 0;

  void reiniciarErroneasConsecutivas(){
    contErroneasConsecutivas = 0;
  }
  void incrementarErroneasConsecutivas(){
    contErroneasConsecutivas++;
  }

  void _logroCreiQueEraPez(String cuenta,String respuesta, BuildContext context)async{
    if(cuenta.contains('2 + 2') && respuesta == '4'){
      _asignacionController.asignarLogro(
        contexto: context, 
        idLogroAAsignar: 9
      );
    }
  }
  void _logroMatematicasHijo(int contador, BuildContext context)async{
    if(contador == 10){
      _asignacionController.asignarLogro(
        contexto: context, 
        idLogroAAsignar: 10
      );
    }
  }

  void _logroParaaa(int contador, BuildContext context)async{
    if(contador == 25){
      _asignacionController.asignarLogro(
        contexto: context, 
        idLogroAAsignar: 11
      );
    }
  }

  void _logroNoMePareceQueEsteChicoSeaMuyListo(BuildContext context)async{
    if(contErroneasConsecutivas == 5){
      _asignacionController.asignarLogro(
        contexto: context, 
        idLogroAAsignar: 12
      );
    }
  }

  void _logroQueMiraBobo(bool esRespuestaCorrecta, String respuesta, BuildContext context)async{
    if(esRespuestaCorrecta && respuesta == '10'){
      _asignacionController.asignarLogro(
        contexto: context, 
        idLogroAAsignar: 13
      );
    }
  }

  void checkearLogros({required String cuentaGenerada, required String resultado, required BuildContext context, required int contTotales, required int contConsecutivas, required bool respondisteBien})async{
    _logroCreiQueEraPez(cuentaGenerada, resultado, context);
    _logroMatematicasHijo(contTotales, context);
    _logroParaaa(contConsecutivas, context);
    _logroNoMePareceQueEsteChicoSeaMuyListo(context);
    _logroQueMiraBobo(respondisteBien, resultado, context);
  }
}