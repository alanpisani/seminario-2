import 'casilla.dart';

class ValidadorTateti {


  String? _validarLinea(List<Casilla> casillas){
    int cruz = 0;
    int circulo = 0;

    for(Casilla casilla in casillas){
      if(casilla.esCruz == null) return null;
      if(casilla.esCruz == true) cruz++;
      if(casilla.esCruz == false) circulo++;
    }
    if(cruz==3) {
      return "Ganó cruz";
    } 
    else if(circulo == 3) {
      return "Ganó círculo";
    }
    return null;

    
  }

  String? _validarFilas(List<List<Casilla>> casillas){
    for(List<Casilla> fila in casillas){
      String? respuesta = _validarLinea(fila);
      if(respuesta != null){
        return respuesta;
      } 
    }
    return null;
  }

  String? _validarColumnas(List<List<Casilla>> casillas){
    List<List<Casilla>> matriz = List.generate(3, (i) {
      return [];
    });

    for(int columna = 0; columna<casillas[0].length;columna++){
      for(int fila = 0; fila<casillas.length; fila++){
        matriz[columna].add(casillas[fila][columna]);
      }
    }
    return _validarFilas(matriz);
    
  }

  String? _validarDiagonal(List<List<Casilla>> casillas){
    List<Casilla> diagonal = [];

    for(int i = 0; i< casillas.length;i++){
      diagonal.add(casillas[i][i]);
    }

    String? respuesta = _validarLinea(diagonal);
    if(respuesta !=  null){
      return respuesta;
    }
    return null;    
  }

  String? _validarDiagonalInversa(List<List<Casilla>> casillas){
    List<Casilla> diagonalInversa = [];

    for(int i = 0; i<casillas.length;i++){
      diagonalInversa.add(casillas[i][casillas[i].length - i - 1]);
    }
    String? respuesta = _validarLinea(diagonalInversa);
      if(respuesta != null){
        return respuesta;
      }
      return null; 
    
  }

  String? validarTodo(List<List<Casilla>> casillas){
    return _validarFilas(casillas) ??
    _validarColumnas(casillas) ??
    _validarDiagonal(casillas) ??
    _validarDiagonalInversa(casillas);
  }

  bool hayganador(String? respuesta){
    return respuesta != null  ? true : false;
  }
}