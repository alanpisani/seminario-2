import 'package:flutter/material.dart';
import '../../../widgets/juegos/piedra_papel_tijera/eleccion_container.dart';

Widget eleccionesSection({required double alturaMaxima, required double anchoMaximo, required String Function(int) imgSeleccion, required int opJugador, required int opCpu}){
  return Container(
    color: Colors.amber,
    child: Column( //Lo que se muestra en la parte superior
      children: [
        eleccionContainer(anchoMaximo, alturaMaxima, imgSeleccion(opJugador), 'VOS', true),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink, width: 2)
          ),
        ),
        eleccionContainer(anchoMaximo, alturaMaxima, imgSeleccion(opCpu), 'CPU', false)
      ],
    ),
  );
}