import 'package:flutter/material.dart';

Widget logroWidget({required BuildContext contexto, required String texto, required String descripcion, required String imgUrl, required bool desbloqueado}){
  final double maxWidth = MediaQuery.of(contexto).size.width;
  final double maxHeight = MediaQuery.of(contexto).size.height;
  final double promedio = (maxHeight + maxWidth) / 2;

  return Container(
    margin: EdgeInsets.all(promedio * 0.0075),
    padding: EdgeInsets.all(promedio * 0.015),
    decoration: BoxDecoration(
      color: ColorScheme.of(contexto).inversePrimary,
      border: Border.all(),
      borderRadius: BorderRadius.circular(promedio * 0.02),
      boxShadow: [
      BoxShadow(
        color: Colors.black,
        blurRadius: 3,
        offset: Offset(0, 5),
      ),
    ],
    ),
    child: Row(
      children: [
        Container(
          width: maxWidth * 0.175,
          height: maxHeight * 0.075,
          decoration: BoxDecoration(
            border: Border.all(width: 2),
            image: DecorationImage(
              image: NetworkImage( desbloqueado ? imgUrl : 'https://i.imgur.com/Pctj3gw.png'),
              fit: BoxFit.cover,
            )
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(promedio * 0.01),
            child: Column(
            children: [
              Text(texto,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(descripcion, 
                textAlign: TextAlign.center,)    
            ],
          ),
          )
        )
      ],
    )
  ); 
}