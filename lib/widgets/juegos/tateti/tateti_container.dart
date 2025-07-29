import 'package:flutter/material.dart';

Widget tatetiContainer({required double promedio, required double altoMaximo, required Color color, required Color colorBorde, required Widget child}){
  return Container(
    margin: EdgeInsets.all(promedio * 0.02),
    height: altoMaximo * 0.9,
    decoration: BoxDecoration(
      color: color,
      border: Border.all(
        color:colorBorde,
        width: 5
      ),
      borderRadius: BorderRadius.circular(promedio * 0.01),
    ),
    child: child,
    );
}