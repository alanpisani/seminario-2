import 'package:flutter/material.dart';

class Precargador {
  bool imagenesCargadas = false;

  Future<void> precargarImagenes( BuildContext context, List<String> imagenes, bool Function() mounted) async{
    for(String url in imagenes){
      if(!mounted()) return;
      await precacheImage(NetworkImage(url), context);
    }
  }

  Future<void> precargarImagen(BuildContext context, String img)async{
    await precacheImage(NetworkImage(img), context);
  }

  void imagenesPrecargadas(){
    imagenesCargadas = true;
  }

}