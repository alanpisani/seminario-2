import 'dart:math';

import '../../../../utils/constants/consts_adivinar_numero.dart';

class MotorAdivinarNumero{
  int numero = Random().nextInt(numeroMasAltoPermitido + 1);
  int _intento = 0;

  int get getIntento => _intento;

  void incrementarIntento(){
    _intento++;
  }

  void _reiniciarIntentos(){
    _intento = 0;
  }
  
  String respuesta(int op){
    if(_intento < intentosMaximos){
      if(op < numeroMasBajoPermitido || op > numeroMasAltoPermitido){
        return "El número es mayor a $numeroMasBajoPermitido y menor que $numeroMasAltoPermitido";
            
      }
      else if(op < numero){
        
        return "El número es más grande que $op";
    
      }
      else if(op > numero){
        return "El número es más chico que $op";
      }
      else{
        return msjAdivinaste;
      }
    }
    return msjPerdiste;
    
  }

  bool ganaste(String respuesta){
    return respuesta.contains(msjAdivinaste);
  }

  bool ganasteOPerdiste(String respuesta){
    return ganaste(respuesta) || respuesta.contains(msjPerdiste);
  }

  void _generarOtroNum(){
    numero = Random().nextInt(numeroMasAltoPermitido + 1);
  }

  void reiniciarAdivinarNumero(){
    _reiniciarIntentos();
    _generarOtroNum();
  }
}