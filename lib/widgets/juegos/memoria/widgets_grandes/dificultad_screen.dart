import 'package:flutter/material.dart';

Widget dificultadScreen({required int cantidadDificultades, required void Function(int) onSeleccionarDificultad, required List<String> listaDificultadTxt}){

  return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Memoria",
            style: TextStyle(
              fontSize: 75
            )
          ),
          Text("Selecciona dificultad",
            style: TextStyle(
              fontSize: 30
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(cantidadDificultades, (i){
              return GestureDetector(
                onTap: () => onSeleccionarDificultad(i),
                child: Container(
                  width: 100,
                  padding: EdgeInsets.only(top:20, bottom: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 5),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.pink
                  ),
                  child: Text(listaDificultadTxt[i],
                    textAlign: TextAlign.center,
                  ),
                )
              );
            }),
          )
        ],
      ),
    ),
  );
}
