// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../utils/general/medidor_pantalla.dart';
import '../../utils/constants/consts_adivinar_numero.dart';
import '../../controllers/puntaje_controller.dart';
import '../../utils/general/volver_a_jugar.dart';
import '../../utils/logic/juegos/adivinar_numero/gestor_input.dart';
import '../../widgets/juegos/adivinar_numero/input_container.dart';
import '../../widgets/juegos/adivinar_numero/respuesta_container.dart';
import '../../utils/logic/juegos/adivinar_numero/gestor_logros.dart';
import '../../utils/logic/juegos/adivinar_numero/motor.dart';

class AdivinarNumero extends StatefulWidget {
  const AdivinarNumero({super.key});

  @override
  State<AdivinarNumero> createState() => _AdivinarNumeroState();
}

class _AdivinarNumeroState extends State<AdivinarNumero> {
  final _puntajeController = PuntajeController();
  final _gestorInput = GestorInput(); 
  final _motor = MotorAdivinarNumero();
  final _gestorLogros = GestorLogrosAdivinarNumero();
  int _puntajeEnBD = 0;

  bool get _enabled => _gestorInput.getEnabled;
  String _pista = 'Ingresa un numero entre el $numeroMasBajoPermitido y el $numeroMasAltoPermitido';

  @override
  void initState() {
    super.initState();
    _traerPuntajeDeLaBD();
  }

  void _traerPuntajeDeLaBD()async{
    _puntajeEnBD = await _puntajeController.traerValorPuntajeDeUsuario(idJuego: 3);
  }

  void _respuesta(){
    _motor.incrementarIntento(); 
    int numUsuario = int.parse(_gestorInput.inputController.text);
    setState(() {
      _gestorInput.limpiarYFocusearInput();
    });
    _gestorLogros.incrementarContador();
    _pista = _motor.respuesta(numUsuario);
    _inhabilitarInputSiTerminaJuego();
    _actualizarRanking(); //Funca solo si se gana
    _gestorLogros.checkearLogros(numUsuario, _motor.numero, context);
  }

  void _inhabilitarInputSiTerminaJuego()async{
    if( _motor.ganasteOPerdiste(_pista)){
      _gestorInput.bloquearInput();

      deseasVolverAJugar(
        context: context, 
        leyenda: _pista, 
        onLoQueHaceSiAceptasSeguir: (){
          setState(() {
            _reiniciarJuego();
          });
        }
      );
    }
  }

  void _reiniciarJuego(){
    _motor.reiniciarAdivinarNumero();
    _gestorInput.habilitarInput();
    _pista = 'Adiviná otro número entre el $numeroMasBajoPermitido y el $numeroMasAltoPermitido';
  }

  void _actualizarRanking()async{
    if(_motor.ganaste(_pista)){
      _puntajeEnBD++;
      await _puntajeController.asignarPuntos(3, _puntajeEnBD);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intentos restantes: ${10 - _motor.getIntento}"),
      ),
      body: Container(
        color: const Color.fromARGB(255, 22, 2, 56),
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(MedidorPantalla.getPromedio(context) * 0.05),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text("Adiviná el numero",
              style: TextStyle(
                color: Colors.teal,
                fontSize: MedidorPantalla.getPromedio(context) * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            respuestaContainer(
              promedio: MedidorPantalla.getPromedio(context), 
              pista: _pista
            ),
            inputContainer(
              enabled: _enabled,
              anchoMaximo: MedidorPantalla.getAnchoMaximo(context), 
              inputController: _gestorInput.inputController, 
              focusNode:_gestorInput.focusNode, 
              onRespuesta: _respuesta
            )
          ],
        ),
      )
    );
  }
}