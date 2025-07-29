import 'package:flutter/material.dart';
import 'marcador_container.dart';


Widget marcadoresSection({required String textoDinamico, required int contRondaJugador, required int contRondaCpu}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      marcadorContainer(contRondaJugador),
      Text(textoDinamico),
      marcadorContainer(contRondaCpu),
    ],
  );
}