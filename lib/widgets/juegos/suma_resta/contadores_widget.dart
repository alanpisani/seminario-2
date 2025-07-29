import 'package:flutter/material.dart';

Widget contadoresWidget({required double unidadMedida, required Color colorContainer, required int marcadorCantTotal, required int marcadorCantConsecutivas}){
return Container(
    color: colorContainer,
    padding: EdgeInsets.all(unidadMedida * 0.02),
    child: Column(
      children: [
        Text("Respuestas correctas totales: $marcadorCantTotal"),
        Text("Respuestas correctas consecutivas: $marcadorCantConsecutivas"),
      ],
    ),
  );
}