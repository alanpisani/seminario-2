import 'dart:math';

import '../../../../utils/constants/consts_sopa_de_letras.dart';
import '../../../../utils/general/reproductor.dart';
import '../../../../utils/logic/juegos/sopa_de_letras/casilla_sopa.dart';
import '../../../../utils/logic/juegos/sopa_de_letras/metepalabras.dart';
import '../../../../utils/logic/juegos/sopa_de_letras/validador_palabras.dart';

class MotorSopaDeLetras {
  final _metepalabras = Metepalabras();

  List<List<CasillaSopa>> matriz = List.generate(dimensionSopa, (int i){
    return List.generate(dimensionSopa, (int x){
      return CasillaSopa(
        fila: i, 
        columna: x, 
        letra: ''
      );
    });
  });
  late List<CasillaSopa> listaLetrasMezcladas = matriz.expand((fila) => fila).toList();
  final List<CasillaSopa> seleccionActual = [];
  int _cantPalabrasCorrectas = 0;

  int get getCantPalabrasCorrectas => _cantPalabrasCorrectas;


  void rellenarMatrizConLetras(List<CasillaSopa> matrizAplanada){
    for(int i = 0; i<matrizAplanada.length;i++){
      if (matrizAplanada[i].letra.isEmpty){
        matrizAplanada[i].letra = abecedario[Random().nextInt(27)];
      }
    }
  }

  void _limpiarSeleccionInvalida() {
    for (var casilla in listaLetrasMezcladas) {
      casilla.despresionar();
    }
    seleccionActual.clear();
  }

    void analizarSecuencia(CasillaSopa tocada) {
    if (tocada.color != colorAmarillo) return;

    if (seleccionActual.isEmpty) {
      seleccionActual.add(tocada);
      return;
    }

    CasillaSopa anterior = seleccionActual.last;

    if (ValidadorPalabras.estanAdyacentes(anterior, tocada)) {
      seleccionActual.add(tocada);
    } else {
      _limpiarSeleccionInvalida();
    }
  }

  void analizarRespuestaPintada(){
    List<String> listPalabra = [];
    List<String> listSeleccionados = [];

    for(int i = 0;i<palabrasParaSopa.length;i++){
      listPalabra = palabrasParaSopa[i].split('');
      listPalabra.sort();
      for(CasillaSopa casilla in seleccionActual){
        listSeleccionados.add(casilla.letra);
      }
      listSeleccionados.sort();
      if(listPalabra.join() == listSeleccionados.join()){
        for(CasillaSopa casilla in seleccionActual){
          casilla.bloquearCasilla();
        }
        _cantPalabrasCorrectas++;
        seleccionActual.clear();
        Reproductor().reproducirSonido("sounds/green-sopa.mp3");
        return;
      }
      listSeleccionados.clear();
    }
  }

  bool ganaste(){
    return _cantPalabrasCorrectas == cantidadPalabrasEnSopa;
  }

  void habilitarCasillas(List<CasillaSopa> matrizAplanada){
    for(CasillaSopa casilla in matrizAplanada){
      casilla.bloqueado = false;
    }
  }

  void deshabilitarCasillas(List<CasillaSopa> matrizAplanada){
    for(CasillaSopa casilla in matrizAplanada){
      casilla.bloquearCasilla(porHaberTerminadoElJuego: true);
    }
  }

  void reiniciarJuego(){
    _cantPalabrasCorrectas = 0;
    matriz = List.generate(dimensionSopa, (int i){
      return List.generate(dimensionSopa, (int x){
        return CasillaSopa(
          fila: i, 
          columna: x, 
          letra: ''
        );
      });
    });
    listaLetrasMezcladas = matriz.expand((fila) => fila).toList();
    _metepalabras.meterTodasLasPalabras(matriz);
    rellenarMatrizConLetras(listaLetrasMezcladas);
  }
  
}