// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../utils/general/medidor_pantalla.dart';
import '../../controllers/puntaje_controller.dart';
import '../../utils/general/volver_a_jugar.dart';
import '../../widgets/juegos/suma_resta/boton_empezar.dart';
import '../../utils/logic/juegos/suma_resta/temporizador.dart';
import '../../widgets/juegos/suma_resta/contadores_widget.dart';
import '../../widgets/juegos/suma_resta/cuentas_widget.dart';
import '../../widgets/juegos/suma_resta/input_widget.dart';
import '../../widgets/juegos/suma_resta/respuesta_widget.dart';
import '../../widgets/juegos/suma_resta/temporizador_widget.dart';
import '../../utils/logic/juegos/suma_resta/cuenta.dart';
import '../../utils/logic/juegos/suma_resta/gestor_logros.dart';
import '../../utils/logic/juegos/suma_resta/marcador.dart';
import '../../utils/logic/juegos/suma_resta/motor.dart';

class SumaResta extends StatefulWidget {
  const SumaResta({super.key});

  @override
  State<SumaResta> createState() => _SumaRestaState();
}

class _SumaRestaState extends State<SumaResta> {
  final _cuenta = Cuenta();
  final _marcador = Marcador();
  final _motor = MotorSumaResta();
  final _temporizador = Temporizador(segundos: 60);
  final _gestorLogros = GestorLogrosSumaResta();
  final _inputController = TextEditingController();
  final _focusNode = FocusNode();
  final _puntuacion = PuntajeController();
  
  String _respuestaEnTexto = 'Resolvé las cuentas';
  bool _disponibilidadInput = false;
  bool _apagarBoton = false;
  String get _cuentaGenerada => _cuenta.cuentaGenerada;
  String get _resultado => _cuenta.resolverCuenta().toString();
  String get _tiempo => _temporizador.segundos.toString();
  
  
  void _ejecutarJuego() async {
    _apagarBoton = true;
    _disponibilidadInput = true;
    _temporizador.cuentaRegresiva(setState: setState, mounted: () => mounted);
    await Future.delayed(Duration(seconds: 60));
    
    _disponibilidadInput = false;
    _apagarBoton = false;
    if(!mounted) return;

    _puntuacion.asignarPuntos(4, _marcador.contTotales);
    
    deseasVolverAJugar(
      context: context, 
      leyenda: "Juego finalizado\nPuntuación: ${_marcador.contTotales}", 
      onLoQueHaceSiAceptasSeguir: (){
        setState((){});
        _temporizador.setearSegundos(60);
        _marcador.reiniciarTodosLosContadores();
      }
    );
  }
  
  void _generarCuenta(){
    setState(() {
      if(_cuenta.respondisteBien(tuRespuesta: _inputController.text)){
        _respuestaEnTexto = _motor.buenasRespuestas();
        _marcador.incrementarContadores();
        _gestorLogros.reiniciarErroneasConsecutivas();
      }else{
        _respuestaEnTexto = _motor.malasRespuestas();
        _marcador.reiniciarContConsecutivas();
        _gestorLogros.incrementarErroneasConsecutivas();
      }
    });
    _gestorLogros.checkearLogros(
      cuentaGenerada: _cuenta.cuentaGenerada, 
      resultado: _resultado, 
      context: context, 
      contTotales: _marcador.contTotales, 
      contConsecutivas: _marcador.contConsecutivas, 
      respondisteBien: _cuenta.respondisteBien(tuRespuesta: _inputController.text)
    );
    _cuenta.reasignarValores();
    _cositasDelInput();
  }

  void _cositasDelInput(){
    _focusNode.requestFocus();
    _inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: const Color.fromARGB(255, 1, 19, 1),
        child: Column(
            children: [
              SizedBox(
                height: MedidorPantalla.getAltoMaximo(context) * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    temporizadorWidget(unidadMedida: MedidorPantalla.getPromedio(context), leyendaTiempo: _tiempo),
                    contadoresWidget(
                      unidadMedida: MedidorPantalla.getPromedio(context), 
                      colorContainer: ColorScheme.of(context).onPrimary, 
                      marcadorCantTotal: _marcador.contTotales, 
                      marcadorCantConsecutivas: _marcador.contConsecutivas
                    ),
                    respuestaWidget(
                      unidadMedida: MedidorPantalla.getPromedio(context),
                      respuesta: _respuestaEnTexto, 
                      listaRespBuenas: _motor.respuestasBuenas
                    ),
                    cuentasWidget(
                      unidadMedida: MedidorPantalla.getPromedio(context), 
                      anchoPantallaMaximo: MedidorPantalla.getAnchoMaximo(context), 
                      cuentaGenerada: _cuentaGenerada
                    ),
                  ],
                ),
              ),
              inputWidget(
                estaDisponible: _disponibilidadInput,
                unidadMedida: MedidorPantalla.getPromedio(context), 
                textEditingController: _inputController, 
                focusNode: _focusNode, 
                funcionGeneradoraCuentas: _generarCuenta
              ),
              botonEmpezar(
                unidadMedida: MedidorPantalla.getPromedio(context), 
                colorBorde: Colors.white70, 
                onPressed: _apagarBoton ? (){} : _ejecutarJuego,
              ),
            ],
          ),
        ),
    );
  }
}