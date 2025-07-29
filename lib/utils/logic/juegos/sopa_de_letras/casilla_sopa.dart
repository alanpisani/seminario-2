import 'package:flutter/material.dart';
import '../../../../utils/constants/consts_sopa_de_letras.dart';

class CasillaSopa{
  int fila;
  int columna;
  Color color = Colors.transparent;
  String letra;
  bool presionado;
  bool bloqueado;

  CasillaSopa({
    required this.fila,
    required this.columna,
    required this.letra,
    this.presionado = false,
    this.bloqueado = true,
  });

  void _cambiarAPresionado(){

    if(color == Colors.transparent){
      presionado = true;
      color = colorAmarillo;
    }

  }

  void despresionar(){
    if(color != colorVerde){
      presionado = false;
      color = Colors.transparent;
    }
  }

  void pintarCasilla(){
    if(!bloqueado){
      if(presionado){
        despresionar();
      }
      else{
        _cambiarAPresionado();
      }
    }
  }

  void bloquearCasilla({bool porHaberTerminadoElJuego = false}){
    bloqueado = true;
    if(!porHaberTerminadoElJuego){
      color = colorVerde;
    }
    
  }
}