import 'package:flutter/material.dart';
import 'cuadradito.dart';

import '../../../../controllers/asignacion_controller.dart';

class GestorLogrosMemoria{
  final _asignacionController = AsignacionController();
  int _intentosTotales = 0;
  int _intentosSinErrarConsecutivos = 0;

  int get getIntentosTotales => _intentosTotales;

  void incrementarIntentosTotales(){
    _intentosTotales++;
  }

  void incrementarIntentosSinErrarConsecutivos(){
    _intentosSinErrarConsecutivos++;
  }

  void reiniciarIntentosConsecutivosSinErrar(){
    _intentosSinErrarConsecutivos = 0;
  }

  void _logroSeHaFormadoUnaPareja(BuildContext context, List<Cuadradito> cuadraditos)async{
    int cuadraditosDesbloqueados = 0;
    for(Cuadradito cuadradito in cuadraditos){
      if(cuadradito.destapado){
        cuadraditosDesbloqueados++;
      }
    }
    if(cuadraditosDesbloqueados == 2){
      _asignacionController.asignarLogro(contexto: context, idLogroAAsignar: 14);
    }
  }

  void _logroPoliamor(BuildContext context, List<Cuadradito> cuadraditos)async{
    for(Cuadradito cuadradito in cuadraditos){
      if(!cuadradito.destapado){
        return;
      }
    }
    _asignacionController.asignarLogro(contexto: context, idLogroAAsignar: 15);
  }

  void _logroALaPrimera(BuildContext context, List<Cuadradito> cuadraditos)async{
    int cuadraditosDesbloqueados = 0;
    for(Cuadradito cuadradito in cuadraditos){
      if(cuadradito.destapado){
        cuadraditosDesbloqueados++;
      }
    }
    if(_intentosTotales == 2 && cuadraditosDesbloqueados == 2){
      await _asignacionController.asignarLogro(contexto: context, idLogroAAsignar: 16);
    }
  }

  void _logroPodranCuestionarMisMetodos(BuildContext context, List<Cuadradito> cuadraditos)async{
    if(_intentosSinErrarConsecutivos == cuadraditos.length / 2){
      await _asignacionController.asignarLogro(contexto: context, idLogroAAsignar: 17);
    }
  }

  void checkearLogros(BuildContext context, List<Cuadradito> cuadraditos) async{
    _logroSeHaFormadoUnaPareja(context, cuadraditos);
    _logroPoliamor(context, cuadraditos);
    _logroALaPrimera(context, cuadraditos);
    _logroPodranCuestionarMisMetodos(context, cuadraditos);
  }

}