import 'package:flutter/material.dart';
import '../../../../controllers/asignacion_controller.dart';

class GestorLogrosPiedraPapelTijera {
  final _asignacionController = AsignacionController();
  int vecesSeguidasMismoElem = 0;
  int valorElemAnterior = -1;
  int _vecesSeguidasPapel = 0;

  void _laBuenaPiedra(int op, int opCpu, BuildContext context)async{
    if(op == 0 && opCpu == 1){
      await _asignacionController.asignarLogro(
        contexto: context, 
        idLogroAAsignar: 3
      );
    }
  }

  void _weyYa(int op, BuildContext context)async{
    if(valorElemAnterior == op){
      vecesSeguidasMismoElem++;
    }
    else{
      vecesSeguidasMismoElem = 1;
    }
    valorElemAnterior = op;

    if(vecesSeguidasMismoElem == 5){
      await _asignacionController.asignarLogro(
        contexto: context, 
        idLogroAAsignar: 4
      );
    }

  }

  void _burocrata(int op, int contRondaJugador, String resp, BuildContext context)async{
    if(op == 1){
      if(resp.contains("¡Ganaste!")){
        _vecesSeguidasPapel++;
      }
    }else{
      _vecesSeguidasPapel = 0;
    }
  
    if(contRondaJugador == 3 && contRondaJugador == _vecesSeguidasPapel){
      _asignacionController.asignarLogro(contexto: context, idLogroAAsignar: 5);
    }
  }

  void _indestructible(int contRondaJugador, int contRondaCpu, BuildContext context) async{
    if(contRondaJugador == 3 && contRondaCpu ==0){
      _asignacionController.asignarLogro(contexto: context, idLogroAAsignar: 6);
    }
  }

  void reiniciarLogros(){
    _vecesSeguidasPapel = 0;
  }

  void checkearLogros(int op, int opCpu, BuildContext context, int contRondaJugador, int contRondaCpu, String resp)async{
    _laBuenaPiedra(op, opCpu, context);
    _weyYa(op, context);
    _burocrata(op, contRondaJugador, resp, context);
    _indestructible(contRondaJugador, contRondaCpu, context);
  }
}

