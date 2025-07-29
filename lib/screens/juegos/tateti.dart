import 'package:flutter/material.dart';
import '../../utils/general/medidor_pantalla.dart';
import '../../controllers/puntaje_controller.dart';
import '../../widgets/juegos/tateti/matriz_widget.dart';
import '../../widgets/juegos/tateti/tateti_container.dart';
import '../../utils/logic/juegos/tateti/casilla.dart';
import '../../utils/logic/juegos/tateti/gestor_logros.dart';
import '../../utils/logic/juegos/tateti/gestor_tateti.dart';
import '../../utils/logic/juegos/tateti/validador_tateti.dart';

class Tateti extends StatefulWidget {
  const Tateti({super.key});

  @override
  State<Tateti> createState() => _TatetiState();
}

class _TatetiState extends State<Tateti> {
  final _gestor = GestorTateti();
  final _validador = ValidadorTateti();
  final _gestorLogros = GestorLogrosTateti();
  final _puntajesController =PuntajeController();
  int _puntajeEnBD = 0;

  List<List<Casilla>> get _casillas => _gestor.casillas;
  List<Casilla> get _listaCasillas => _gestor.listaCasillas;
  String? get _respuesta => _validador.validarTodo(_casillas);

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    _puntajeEnBD = await _puntajesController.traerValorPuntajeDeUsuario(idJuego: 6);
  }

  void _ejecutarJugada(int index) {
    if (_listaCasillas[index].esPresionable == false) return;
    _gestor.marcarEleccionJugadorEnMatriz(index);
    setState(() {
      
      if (_validador.hayganador(_respuesta)) {
        _gestor.invalidarCasillas(_listaCasillas);
        _puntajeEnBD++;
        _puntajesController.asignarPuntos(6, _puntajeEnBD);
        return;
      }

      _gestor.jugadaCpu();

      if (_validador.hayganador(_respuesta)) {
        _gestor.invalidarCasillas(_listaCasillas);
      }
    });

    _chequearLogros();
  }

  void _chequearLogros()async{
    _gestorLogros.logroTresEnFila(context, _respuesta ?? '');
    _gestorLogros.logroEmpachi(context, _listaCasillas, _respuesta ?? '');
  }

  void reiniciar(){
    setState(() {
      _gestor.reiniciarjuego();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: tatetiContainer(
        promedio: MedidorPantalla.getPromedio(context), 
        altoMaximo: MedidorPantalla.getAltoMaximo(context), 
        color: const Color.fromARGB(255, 25, 1, 66), 
        colorBorde: Colors.deepPurple, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: reiniciar,
              child: Icon(Icons.refresh)
            ),
            Text(_respuesta ?? '',
              style: TextStyle(
                letterSpacing: 10,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            matrizWidget(
              alturaMaxima: MedidorPantalla.getAltoMaximo(context), 
              onEjecutarJugada: _ejecutarJugada,
              listaCasillas: _listaCasillas
            )
          ],
        )
      ),
    );
  }
}