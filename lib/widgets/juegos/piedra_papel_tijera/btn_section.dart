import 'package:flutter/material.dart';
import '../../../utils/logic/juegos/piedra_papel_tijera/elemento.dart';
import 'btn_elemento.dart';

Widget btnSection({required double promedio, required double alturaMaxima, required double anchoMaximo, required List<ElementoJuego> listaElementos, required void Function(int) onEjecutarJuego}){
  return Expanded(
    child: Container(
      color: Colors.pink,
      padding:EdgeInsets.all(promedio * 0.05),
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          botonElemento(anchoMaximo, alturaMaxima, listaElementos[0], onEjecutarJuego),
          botonElemento(anchoMaximo, alturaMaxima, listaElementos[1], onEjecutarJuego),
          botonElemento(anchoMaximo, alturaMaxima, listaElementos[2], onEjecutarJuego)
        ],
      ),
    )
  );
}