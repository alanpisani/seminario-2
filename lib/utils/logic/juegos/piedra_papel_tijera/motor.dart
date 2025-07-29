import 'dart:math';

class MotorPiedraPapelTijera{
  int _contRondaJugador = 0;
  int _contRondaCPU = 0;
  int _dueloGanadoOp = 0;
  int _dueloGanadoCPU = 0;

  int get getContRondaJugador  => _contRondaJugador;
  int get getContRondaCPU  => _contRondaCPU;
  int get getDueloGanadoOp => _dueloGanadoOp;
  int get getDueloGanadoCPU => _dueloGanadoCPU;


  int eleccionElementoCpu(){
    var random = Random();
    int opCpu = random.nextInt(3);
    return opCpu;
  }  

  String textoRespuesta(int op, int opCpu){
    if(op == opCpu){
      return "Empate";
    }
    else{
      switch(op){
        case 0: return opCpu == 1 ? "¡Perdiste!" : "¡Ganaste!";
                
        case 1: return opCpu == 2 ? "¡Perdiste!" : "¡Ganaste!";
                
        case 2: return opCpu == 0 ? "¡Perdiste!" : "¡Ganaste!";
                
        default: return "Hubo un error";
      }
    }
  }

  void setearMarcadores(int op, int opCpu){
    String resp = textoRespuesta(op, opCpu);

    if(resp.contains("¡Ganaste!")){
      _contRondaJugador++;
    }
    else if(resp.contains('¡Perdiste!')){
      _contRondaCPU++;
    }
  }

  void reiniciarMarcador(){
    _contRondaJugador = 0;
    _contRondaCPU = 0;
  }

  bool hayGanador(){
    return _contRondaCPU == 3 || _contRondaJugador == 3;
  }

  void incrementarDuelosGanados(){
    if(_contRondaCPU == 3){
      _dueloGanadoCPU++;
    }
    else{
      _dueloGanadoOp++;
    }
  }

}