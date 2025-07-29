import 'package:flutter/material.dart';
import '../../../utils/logic/juegos/piedra_papel_tijera/elemento.dart';
  
Widget botonElemento(double maxWidth, double maxHeight, ElementoJuego elemento, Function funcion){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () => funcion(elemento.valor),
        child: Container(
          width: maxWidth *0.2,
          height: maxHeight *0.1,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.amber,
            border: Border.all(width: 5, color: Colors.deepPurple),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage('https://i.imgur.com/${elemento.img}.png')
            )
          ),
        ),                        
      ),
      Text(elemento.nombre,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      )
    ],
  );
}