import 'dart:math';

import 'casilla.dart';

class GestorTateti{
  bool _cruz = true;
  List<List<Casilla>> casillas =  List.generate(3, (i){
    return List.generate(3, (j){
      // return null;
      return Casilla();
    });
  });
  List<Casilla> listaCasillas = List.generate(9, (i) => Casilla());

  void marcarEleccionJugadorEnMatriz(int index){
    int cont = 0;
    for(int i=0;i<casillas.length;i++){
      for(int j=0;j<casillas[i].length;j++){
        if(index == cont){
          casillas[i][j] = Casilla();
          casillas[i][j].esCruz = _cruz;
          casillas[i][j].esPresionable = false;
          _cruz = !_cruz;
          listaCasillas[index] = casillas[i][j];
          return;
        }
        cont++;
      }
    }  
  }

  void jugadaCpu(){
    bool bandera = true;
    if(!_hayCasillasSinJugar()){
      return;
    }
    while(bandera){
      int fila = Random().nextInt(3);
      int columna = Random().nextInt(3);
      if(casillas[fila][columna].esCruz == null){
        int index = fila * 3 + columna;
        
        casillas[fila][columna] = Casilla();
        casillas[fila][columna].esCruz = _cruz;
        casillas[fila][columna].esPresionable = false;
        listaCasillas[index] = casillas[fila][columna]; 
        _cruz = !_cruz;
        bandera = false;
      
      }
    }
  }

  bool _hayCasillasSinJugar(){
    for(List<Casilla> fila in casillas){
      for(Casilla casilla in fila){
        if(casilla.esCruz == null) return true;
      }
    }
    return false;
  }

  void invalidarCasillas(List<Casilla> casillas){

    for(Casilla casilla in casillas){
      if(casilla.esPresionable){
        casilla.esPresionable = false;
      }
    }
    
  }

  void reiniciarjuego(){
    _cruz = true;
    casillas =  List.generate(3, (i){
      return List.generate(3, (j){
      // return null;
        return Casilla();
      });
    });
    listaCasillas = List.generate(9, (i) => Casilla());
  }

}