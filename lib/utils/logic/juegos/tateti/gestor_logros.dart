import 'package:flutter/material.dart';
import '../../../../utils/logic/juegos/tateti/casilla.dart';
import '../../../../controllers/asignacion_controller.dart';

class GestorLogrosTateti{
  final _asignacionController = AsignacionController();

  void logroTresEnFila(BuildContext context,String respuesta)async{
    if (respuesta == 'Ganó cruz'){
      _asignacionController.asignarLogro(contexto: context, idLogroAAsignar: 18);
    }
  }

  void logroEmpachi(BuildContext context, List<Casilla> lista, String respuesta)async{
    bool finDelJuego = true;
    for(Casilla casilla in lista){
      if(casilla.esPresionable){
        finDelJuego = false;
        break;
      }
    }
    if(finDelJuego && respuesta.isEmpty){
      _asignacionController.asignarLogro(contexto: context, idLogroAAsignar: 19);
    }
  }
}