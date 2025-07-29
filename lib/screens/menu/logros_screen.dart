// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '/utils/general/medidor_pantalla.dart';
import '/widgets/menu/home/mostrador_de_logros.dart';
import '../../controllers/asignacion_controller.dart';
import '../../utils/general/precargador.dart';
import '../../utils/logic/logros/filtrador_logros.dart';
import '../../utils/logic/usuarios/sesionador.dart';
import '../../controllers/logro_controller.dart';
import '../../models/logro_model.dart';

class LogrosScreen extends StatefulWidget {
  const LogrosScreen({super.key});

  @override
  State<LogrosScreen> createState() => _LogrosScreenState();
}

class _LogrosScreenState extends State<LogrosScreen> {
  final _filtradorLogros = FiltradorLogros();
  final _logroController = LogroController();
  final _precargadorImg = Precargador();

  List<Logro> get _logrosDesbloqueados => _filtradorLogros.getLogrosDesbloqueados;
  List<Logro> get _logrosSinDesbloquear => _filtradorLogros.getLogrosSinDesbloquear;

  bool _hayImagenesCargadas = false;
  bool _logrosCargados = false;


  @override
  void initState() {
    super.initState();
    _precargarImagenes();
    _mostrarLosLogros();
    _logroMaestro();
  }

  Future<void> _precargarImagenes()async{
    final List<Logro> logros = await _logroController.traerLogros();
    final List<String> logrosImg = logros.map((logro) => logro.urlLogroAlan).toList();


    await _precargadorImg.precargarImagenes(context, logrosImg, () => mounted);
    if (!mounted) return;

    setState(() {
      _hayImagenesCargadas = true;
    });
  }

  void _mostrarLosLogros()async{
    await _filtradorLogros.traerLosLogros(mounted);
    _logrosCargados = true;
  }

  void _logroMaestro()async{
    final int? idUsuario = await Sesionador.retornarId();
    if (idUsuario == null || !mounted) return; 

    if(_logrosSinDesbloquear.isEmpty && _logrosCargados){
      await AsignacionController().asignarLogro(contexto: context, idLogroAAsignar: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!_hayImagenesCargadas && !_logrosCargados){
      return Scaffold(
        body: Center(
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Cargando los logros. Esperá..."),
              CircularProgressIndicator(color: Colors.green,)
            ],
          ),
        ),
      )
      );
    }
    
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorScheme.of(context).onPrimary,
            border: Border.all(color: ColorScheme.of(context).onPrimary)
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(MedidorPantalla.getPromedio(context) * 0.02),
                child: Text("Logros conseguidos",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MedidorPantalla.getPromedio(context) * 0.05
                  ),
                ),
              ),
              mostradorDeLogros(context, _logrosDesbloqueados, true, "Aún no desbloqueaste logros. Jugá y desbloquealos a todos"),
              Padding(
                padding: EdgeInsets.all(MedidorPantalla.getPromedio(context) * 0.02),
                child: Text("Logros faltantes",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MedidorPantalla.getPromedio(context) * 0.05
                  )
                ),
              ),
              mostradorDeLogros(context, _logrosSinDesbloquear, false, "¡Felicidades! ¡No te quedan logros por desbloquear! Esperá la próxima actualización")
            ],
          )
        ),
      ),
    );
  }
}