import 'package:flutter/material.dart';

Widget temporizadorWidget({required double unidadMedida, required String leyendaTiempo}){
return Container(
    padding: EdgeInsets.all(unidadMedida * 0.02),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white70, width: 2),
      shape: BoxShape.circle
    ),
    child: Text(leyendaTiempo,
      style: TextStyle(
        fontSize: unidadMedida * 0.03
      ),
    ),
  );
}