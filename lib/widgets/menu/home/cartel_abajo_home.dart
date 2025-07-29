import 'package:flutter/material.dart';
import '../../../utils/constants/consts_home.dart';

class CartelAbajoHome extends StatelessWidget {
  final int indice;
  const CartelAbajoHome({
    super.key,
    required this.indice
  });

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double maxHeight = MediaQuery.of(context).size.height;
    final double promedio = (maxWidth + maxHeight) / 2;
    
    return Container(
      alignment: Alignment.center,
      height: maxHeight * 0.2,
      margin: EdgeInsets.all(promedio * 0.02),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(promedio * 0.05),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(1, 3)
          ),
        ]

      ),
      child: Text(descripcionHome[titulosHome[indice]]!,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "OptimusPrinceps",
          fontWeight: FontWeight.bold,
          fontSize: promedio * 0.04
        ),
      ),
    );
  }
}