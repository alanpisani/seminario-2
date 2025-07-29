// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../utils/general/medidor_pantalla.dart';
import '../../utils/general/reproductor.dart';
import '../../controllers/puntaje_controller.dart';
import '../../widgets/juegos/piedra_papel_tijera/btn_section.dart';
import '../../widgets/juegos/piedra_papel_tijera/elecciones_section.dart';
import '../../widgets/juegos/piedra_papel_tijera/marcadores_section.dart';
import '../../utils/general/volver_a_jugar.dart';
import '../../utils/logic/juegos/piedra_papel_tijera/gestor_elemento.dart';
import '../../utils/logic/juegos/piedra_papel_tijera/elemento.dart';
import '../../utils/logic/juegos/piedra_papel_tijera/gestor_logros.dart';
import '../../utils/logic/juegos/piedra_papel_tijera/motor.dart';

class PiedraPapelTijera extends StatefulWidget {
  const PiedraPapelTijera({super.key});

  @override
  State<PiedraPapelTijera> createState() => _PiedraPapelTijeraState();
}

class _PiedraPapelTijeraState extends State<PiedraPapelTijera> {
  final _gestorElementos = GestorElemento();
  final _motor = MotorPiedraPapelTijera();
  final _gestorLogros = GestorLogrosPiedraPapelTijera();
  final _puntajesController = PuntajeController();

  List<ElementoJuego> get _elementos => _gestorElementos.getElementos;

  int _opJugador = 0;
  int _opCpu = 0;
  int _puntajeEnBD = 0;
  String _textoDinamico = 'A Jugar!';

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    _puntajeEnBD = await _puntajesController.traerValorPuntajeDeUsuario(idJuego: 2);
  }

  void _eleccionUsuarioYDeCPU(int op){
    setState(() {
      _opJugador = op;
      _opCpu = _motor.eleccionElementoCpu();
      _textoDinamico = _motor.textoRespuesta(op, _opCpu);
    });
  }

  void _duelo(int op)async{
    _motor.setearMarcadores(op, _opCpu);
    if(_motor.hayGanador()){
      _motor.incrementarDuelosGanados();
      Reproductor().reproducirSonido("sounds/win-ppt.mp3");
      if(_textoDinamico.contains("¡Ganaste!")){
        _puntajeEnBD++;
        _puntajesController.asignarPuntos(2, _puntajeEnBD);
      }

      deseasVolverAJugar(context: context,
        leyenda: _textoDinamico, 
        onLoQueHaceSiAceptasSeguir: (){
          
          setState((){
            _textoDinamico = 'jugador ${_motor.getDueloGanadoOp}      ${_motor.getDueloGanadoCPU} CPU';
          });
          
          _reiniciarJuego();
        }
      );
    }
  }

  void _reiniciarJuego(){
    _motor.reiniciarMarcador();
    _gestorLogros.reiniciarLogros();
  }

  void _ejecutarJuego(int op) async{
    Reproductor().reproducirSonido("sounds/pick.mp3");
    _eleccionUsuarioYDeCPU(op);
    _duelo(op);
    _gestorLogros.checkearLogros(op, _opCpu, context, _motor.getContRondaJugador, _motor.getContRondaCPU, _textoDinamico);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Piedra, papel o tijera"),
      ),
      body: Column(
        children: [
          marcadoresSection(
            textoDinamico: _textoDinamico, 
            contRondaJugador: _motor.getContRondaJugador, 
            contRondaCpu: _motor.getContRondaCPU
          ),
          eleccionesSection(
            alturaMaxima: MedidorPantalla.getAltoMaximo(context), 
            anchoMaximo: MedidorPantalla.getAnchoMaximo(context), 
            imgSeleccion: _gestorElementos.obtenerImagen, 
            opJugador: _opJugador, 
            opCpu: _opCpu
          ),
          btnSection(
            promedio: MedidorPantalla.getPromedio(context),
            alturaMaxima: MedidorPantalla.getAltoMaximo(context), 
            anchoMaximo: MedidorPantalla.getAnchoMaximo(context), 
            listaElementos: _elementos, 
            onEjecutarJuego: _ejecutarJuego
          )
        ],
      ),
    );
  }
}