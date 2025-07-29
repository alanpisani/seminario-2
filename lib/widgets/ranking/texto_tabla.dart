import 'package:flutter/material.dart';

Widget textoTabla({required int flex, required String texto, Color? color}){
  return Expanded(
    flex: flex, 
    child: Text(texto, 
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: 20
      ),
    ));
}