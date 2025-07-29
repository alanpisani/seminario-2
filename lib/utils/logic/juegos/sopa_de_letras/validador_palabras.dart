import '../../../../utils/logic/juegos/sopa_de_letras/casilla_sopa.dart';

class ValidadorPalabras {
  static bool sePuedeInsertarHorizontal(List<List<CasillaSopa>> matriz, String palabra, int fila, int columna) {
    if (columna + palabra.length > matriz[fila].length) return false;

    for (int i = 0; i < palabra.length; i++) {
      String actual = matriz[fila][columna + i].letra;
      if (actual.isNotEmpty) { //No se me ocurre como cruzar palabras correctas y validarlas todavía
        return false;
      }
    }
    return true;
  }

  static bool sePuedeInsertarVertical(List<List<CasillaSopa>> matriz, String palabra, int fila, int columna) {
    if (fila + palabra.length > matriz.length) return false;

    for (int i = 0; i < palabra.length; i++) {
      String actual = matriz[fila + i][columna].letra;
      if (actual.isNotEmpty) { //No se me ocurre como cruzar palabras correctas y validarlas todavía
        return false;
      }
    }
    return true;
  }

  static bool estanAdyacentes(CasillaSopa a, CasillaSopa b) {
    bool mismaFila = a.fila == b.fila;
    bool mismaColumna = a.columna == b.columna;

    int diferenciaFila = (a.fila - b.fila).abs();
    int diferenciaColumna = (a.columna - b.columna).abs();

    if (mismaFila && diferenciaColumna == 1) return true;

    if (mismaColumna && diferenciaFila == 1) return true;

    return false;
  }
}