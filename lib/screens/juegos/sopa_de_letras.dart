// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../utils/general/medidor_pantalla.dart';
import '../../controllers/puntaje_controller.dart';
import '../../utils/general/reproductor.dart';
import '../../utils/general/volver_a_jugar.dart';
import '../../utils/logic/juegos/sopa_de_letras/casilla_sopa.dart';
import '../../utils/logic/juegos/sopa_de_letras/gestor_logros.dart';
import '../../utils/logic/juegos/sopa_de_letras/metepalabras.dart';
import '../../utils/logic/juegos/sopa_de_letras/motor_sopa_de_letras.dart';
import '../../utils/logic/juegos/suma_resta/temporizador.dart';
import '../../widgets/juegos/sopa_de_letras/la_sopa_de_letras.dart';
import '../../widgets/juegos/suma_resta/boton_empezar.dart';
import '../../widgets/juegos/suma_resta/temporizador_widget.dart';

class SopaDeLetras extends StatefulWidget {
  const SopaDeLetras({super.key});

  @override
  State<SopaDeLetras> createState() => _SopaDeLetrasState();
}

class _SopaDeLetrasState extends State<SopaDeLetras> {
  final _motor = MotorSopaDeLetras();
  final _metepalabras = Metepalabras();
  final _temporizador = Temporizador(segundos: 0);
  final _gestorLogros = GestorLogrosSopaDeLetras();
  final _puntajeController = PuntajeController(); 

  List<List<CasillaSopa>> get _matriz => _motor.matriz;
  List<CasillaSopa> get _listaLetrasMezcladas => _motor.listaLetrasMezcladas;
  bool _bandera = true;

  @override
  void initState() {
    super.initState();
    _metepalabras.meterTodasLasPalabras(_matriz);
    _motor.rellenarMatrizConLetras(_listaLetrasMezcladas);
  }

  void _empezar(){
    setState(() {
      if(_bandera){
        _temporizador.activarCronometro(setState: setState, mounted: () => mounted);
        _motor.habilitarCasillas(_listaLetrasMezcladas);
        _bandera = false;
      }
    });
  }


  void _aJugar(int i)async{
    setState(() {
      _listaLetrasMezcladas[i].pintarCasilla();
      _motor.analizarSecuencia(_listaLetrasMezcladas[i]);
      _motor.analizarRespuestaPintada();
    });
    if(_motor.ganaste()){
      Reproductor().reproducirSonido("sounds/win-sopa-2.mp3");
      _temporizador.detenerCronometro();
      await _puntajeController.asignarPuntos(7, _temporizador.segundos);
      _gestorLogros.checkearLogros(context, _motor.getCantPalabrasCorrectas, _temporizador.segundos);
      deseasVolverAJugar(
        context: context, 
        leyenda: "Ganaste", 
        onLoQueHaceSiAceptasSeguir: _reiniciar
      );

      
    }
  }

  void _reiniciar(){
    setState(() {
      _motor.reiniciarJuego();
      _temporizador.reiniciarCronometro();
      _temporizador.setearSegundos(0);
      _motor.deshabilitarCasillas(_listaLetrasMezcladas);
      _bandera = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(MedidorPantalla.getPromedio(context) * 0.01),
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.transparent, Colors.blue], 
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
        ),
        child:  Column(
          children: [
            temporizadorWidget(
              unidadMedida: MedidorPantalla.getPromedio(context), 
              leyendaTiempo: _temporizador.segundos.toString()
            ),
            Container(
              margin: EdgeInsets.all(MedidorPantalla.getPromedio(context) * 0.06),
              child: botonEmpezar(
                unidadMedida: MedidorPantalla.getPromedio(context), 
                colorBorde: Colors.red, 
                onPressed: () =>  _empezar()
              ),
            ),
            LaSopaDeLetras(
              listaLetrasMezcladas: _listaLetrasMezcladas, 
              onCLickLetra: _aJugar
            )
          ],
        ),
      ),
    );
  }
}