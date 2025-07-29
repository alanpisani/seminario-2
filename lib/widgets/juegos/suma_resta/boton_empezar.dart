import 'package:flutter/material.dart';

Widget botonEmpezar({required double unidadMedida, required, required Color colorBorde, required VoidCallback onPressed, Color? color}){
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.all(unidadMedida * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: colorBorde),
        borderRadius: BorderRadius.circular(unidadMedida * 0.01),
        color: color ?? Colors.transparent
      ),
      child: Text("Empezar"),
    )
  );
}