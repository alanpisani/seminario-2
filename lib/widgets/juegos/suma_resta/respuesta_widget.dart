import 'package:flutter/material.dart';

Widget respuestaWidget({required double unidadMedida, required String respuesta, required List<String> listaRespBuenas}){
    return Text(respuesta,
    style: TextStyle(
      color: respuesta == "Resolvé las cuentas" 
        ? null 
        : (listaRespBuenas.contains(respuesta) ? Colors.green : Colors.red),
      fontSize: unidadMedida * 0.04
    ),
  );
}