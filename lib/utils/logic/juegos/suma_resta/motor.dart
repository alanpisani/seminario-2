import 'dart:math';

class MotorSumaResta{
  final List<String> respuestasBuenas = ["Bien", "Genio", "Mastodonte", "Crack", "Qué grande", "ídolo", "Capo"];
  final List<String> respuestasMalas = ["Mal", "Burro", "Pecho frío", "Pecho congelado", "Pecho helado", "No", "A Marzo"];

  String buenasRespuestas(){
    return respuestasBuenas[Random().nextInt(respuestasBuenas.length)];
  }
  String malasRespuestas(){
    return respuestasMalas[Random().nextInt(respuestasBuenas.length)];
  }
}