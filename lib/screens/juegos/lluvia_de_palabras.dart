import 'dart:math';

import 'package:flutter/material.dart';
import '../../utils/general/medidor_pantalla.dart';
import '../../controllers/puntaje_controller.dart';
import '../../utils/constants/consts_lluvia_de_palabras.dart';
import '../../utils/general/volver_a_jugar.dart';
import '../../utils/logic/juegos/adivinar_numero/gestor_input.dart';
import '../../utils/logic/juegos/lluvia_de_palabras/gestor_contadores.dart';
import '../../utils/logic/juegos/lluvia_de_palabras/motor_lluvia_de_palabras.dart';
import '../../utils/logic/juegos/suma_resta/temporizador.dart';

class LluviaDePalabras extends StatefulWidget {
  const LluviaDePalabras({super.key});

  @override
  State<LluviaDePalabras> createState() => _LluviaDePalabrasState();
}

class _LluviaDePalabrasState extends State<LluviaDePalabras> {
  final _puntajeController = PuntajeController();
  final _motor = MotorLluviaDePalabras();
  final _contadores = GestorContadores();
  final _temporizador = Temporizador(segundos: segundosLluviaDePalabras);

  int numRandom = Random().nextInt(4) + 1;
  late int categoriaAlAzar = Random().nextInt(categoriasYSusPalabras.length);
  int _go = 3;
  Color _colorDeFondo = Colors.brown;

  double _opacidad = 0;
  double _opacidadGo = 1;
  bool get _enable => _gestorInput.getEnabled;

  final _gestorInput = GestorInput();
  String _respController = "Ingresá acá abajo";

  @override
  void initState() {
    super.initState();
    _inicio();
  }

  Future<void> enSusMarcas()async{
    _opacidadGo = 1;
    setState(() {
      _go = 3; 
    });
    await Future.delayed(Duration(seconds: 1));
    if(!mounted) return;
    setState(() {
      _go--;
    });
    await Future.delayed(Duration(seconds: 1));
    if(!mounted) return;
    setState(() {
      _go--;
    });
    await Future.delayed(Duration(seconds: 1));
    if(!mounted) return;
    setState(() {
      _opacidadGo = 0;
    });
  }

  void _aparecerMsjCambio()async{
    setState(() {
      _opacidad = 1;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _opacidad = 0;
    });
  }

  void _mostrarMensajeCambiooo()async{
    if(_contadores.getIntentos  == numRandom){
      _contadores.reiniciarIntentos();
      
      numRandom = Random().nextInt(4) + 1;
      categoriaAlAzar = _motor.cambiarCategoriaAlAzar(categoriaAlAzar);
      _colorDeFondo = coloresLluviaDePalabras[categoriaAlAzar];
      _aparecerMsjCambio();
    }
  }

  void _inicio()async{
    _gestorInput.bloquearInput();
    _contadores.reiniciarContadores();
    _motor.limpiarListPalabrasMetidas();
    await enSusMarcas();
    _gestorInput.habilitarInput();
    _temporizador.setearSegundos(segundosLluviaDePalabras);
    _temporizador.cuentaRegresiva(setState: setState, mounted: () => mounted);
    await Future.delayed(Duration(seconds: segundosLluviaDePalabras));
    if(!mounted) return;

    await _puntajeController.asignarPuntos(8, _contadores.getContador);

    deseasVolverAJugar(
      // ignore: use_build_context_synchronously
      context: context, 
      leyenda: "Se acabó el tiempo!\nRespuestas correctas: ${_contadores.getContador}", 
      onLoQueHaceSiAceptasSeguir: (){
        _inicio();
      }
    );

  }

  void _ingresarPalabra(){
    String palabraNormalizada = _motor.normalizarPalabra(_gestorInput.inputController.text);
    setState(() {
      _respController = _motor.retornarRespuesta(palabraNormalizada, 
      categoriasYSusPalabras[_motor.categoriasLluviaDePalabras[categoriaAlAzar]]!);
    });
    _contadores.incrementarIntentos();
    if(_motor.esCorrecta(palabraNormalizada, categoriasYSusPalabras[_motor.categoriasLluviaDePalabras[categoriaAlAzar]]!)){
      _contadores.incrementarContador();
    }
    _mostrarMensajeCambiooo();
    _gestorInput.limpiarYFocusearInput();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: _colorDeFondo,
        child: Stack(
          children: [
            Container(
              height: MedidorPantalla.getAltoMaximo(context) * 0.5,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(MedidorPantalla.getPromedio(context) * 0.02),
                    height: MedidorPantalla.getAltoMaximo(context) * 0.075,
                    width: double.infinity, //por ahora
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.blue
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Respuestas correctas"),
                            Text(_contadores.getContador.toString())
                          ],
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text("Tiempo restante"),
                              Text(_temporizador.segundos.toString())
                            ],
                          ),
                      ],
                    ),
                  ),
                  Container(
                    height: MedidorPantalla.getAltoMaximo(context) * 0.2,
                    width: double.infinity,
                    margin: EdgeInsets.all(MedidorPantalla.getPromedio(context) * 0.015),
                    padding: EdgeInsets.all(MedidorPantalla.getPromedio(context) * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MedidorPantalla.getPromedio(context) * 0.02),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Escribí ${_motor.categoriasLluviaDePalabras[categoriaAlAzar]}!",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.black
                        ),),
                        Text(_respController,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: _gestorInput.inputController,
                    focusNode: _gestorInput.focusNode,
                    enabled: _enable,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    ),
                    onSubmitted: (String _){
                      _ingresarPalabra();
                    },
                  ),
                ],
              )
            ),
            IgnorePointer(
              ignoring: _opacidadGo == 0,
              child: AnimatedOpacity(
                opacity: _opacidadGo, 
                duration: Duration(milliseconds: 200),
                child: Center(
                  child: Text(_go.toString(),
                    style: TextStyle(
                      fontSize: 150,
                    ),
                  ),
                )
              ),
            ),
            IgnorePointer(
              ignoring: _opacidad == 0,
              child: AnimatedOpacity(
                opacity: _opacidad, 
                duration: Duration(milliseconds: 300),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(MedidorPantalla.getPromedio(context) * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MedidorPantalla.getPromedio(context) * 0.03),
                      color: Colors.black,
                    ),
                    child: Text("¡CAMBIO!",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ),
              )
            )
          ],
        )
      )
    );
  }
}