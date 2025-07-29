import 'package:flutter/material.dart';

Widget cuentasWidget({required double unidadMedida, required double anchoPantallaMaximo, required String cuentaGenerada}){
  return Container(
    width: anchoPantallaMaximo * 0.5,
    padding: EdgeInsets.all(unidadMedida * 0.02),
    decoration: BoxDecoration(
      border: Border.all(color:Colors.white, width: 3)
    ),
    child: Text(cuentaGenerada, 
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: unidadMedida * 0.04
      ),
    ),
  );
}