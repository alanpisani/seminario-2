// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../utils/general/precargador.dart';
import '../../utils/general/volver_a_jugar.dart';
import '../../widgets/juegos/memoria/widgets_grandes/dificultad_screen.dart';
import '../../widgets/juegos/memoria/widgets_grandes/memoria_screen.dart';
import '../../utils/logic/juegos/memoria/gestor_cuadraditos.dart';
import '../../utils/logic/juegos/memoria/gestor_logros.dart';
import '../../utils/logic/juegos/memoria/motor.dart';
import '../../utils/logic/juegos/memoria/cuadradito.dart';

class Memoria extends StatefulWidget {
  const Memoria({super.key});

  @override
  State<Memoria> createState() => _MemoriaState();
}

class _MemoriaState extends State<Memoria> {
  final _motor = MotorMemoria();
  GestorCuadraditos _gestorCuadraditos = GestorCuadraditos(dificultad: 0);
  final _gestorLogros = GestorLogrosMemoria();
  final _precargadorImg = Precargador();
  Key _keyHijo = UniqueKey();
  
  int _dificultad = 0;
  bool get _dificultadSeleccionada => _motor.getDificultadSeleccionada();
  bool get _hayImagenesCargadas => _precargadorImg.imagenesCargadas;
  late List<Cuadradito> _cuadraditos = _gestorCuadraditos.getCuadraditos();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precargarImagenes();
  }

  void _precargarImagenes() async{
    await _precargadorImg.precargarImagenes(context, _gestorCuadraditos.imagenesCuadraditos, () => mounted);
    if(!mounted) return;
    await _precargadorImg.precargarImagen(context, 'https://i.imgur.com/KncBIaP.png'); 
    
    setState(() {
      _precargadorImg.imagenesPrecargadas();
    });
  }
  
  void _seleccionarDificultad(int i){
    _motor.yaSeSeleccionoDificultad();
    setState(() {
      _gestorCuadraditos = GestorCuadraditos(dificultad: i);
      _dificultad = i;
    });
  }

  int _casillasPorFila(){
    return 4 - _gestorCuadraditos.dificultad;
  }

  Future<void> _eligiendoCuadradito(int i) async {
    if (!_cuadraditos[i].presionable) return;
    bool fuePareja = await _motor.procesoEleccionCuadradito(i, _cuadraditos, setState: setState);
    _gestorLogros.incrementarIntentosTotales();

    if (fuePareja) {
      _gestorLogros.incrementarIntentosSinErrarConsecutivos();
      _gestorLogros.checkearLogros(context, _cuadraditos);
    }
    else if(_gestorLogros.getIntentosTotales % 2 == 0){
      _gestorLogros.reiniciarIntentosConsecutivosSinErrar();
    }
  }

  void _clickAlCuadradito(int i) async{
    await _eligiendoCuadradito(i);

    for(Cuadradito cuadradito in _cuadraditos){
      if(!cuadradito.destapado) return;
    }
    deseasVolverAJugar(
      context: context, 
      leyenda: "Se acabó el juego", 
      onLoQueHaceSiAceptasSeguir: _reiniciarJuego
    );
    
  }

  void _reiniciarJuego(){
    setState(() {
      _cuadraditos = _gestorCuadraditos.mezclarYtaparCuadraditos();
      _keyHijo = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!_dificultadSeleccionada){
      return dificultadScreen(
        cantidadDificultades: _gestorCuadraditos.getDificultadesTxt().length, 
        onSeleccionarDificultad: _seleccionarDificultad, 
        listaDificultadTxt: _gestorCuadraditos.getDificultadesTxt()
      );
    }
    else if(!_hayImagenesCargadas){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return MemoriaJuego(
      key: _keyHijo,
      cuadraditos: _cuadraditos,
      onBuscandoPareja: _clickAlCuadradito,
      casillasPorFila: _casillasPorFila(),
      estaEnDificil: _dificultad == 2 ? true : false,
    );
  }
}