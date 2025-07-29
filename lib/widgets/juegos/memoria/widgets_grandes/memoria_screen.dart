import 'package:flutter/material.dart';
import '../../../../controllers/puntaje_controller.dart';
import '../../../../utils/logic/juegos/memoria/cuadradito.dart';
import '../../../../utils/logic/juegos/suma_resta/temporizador.dart';
import '../../../../widgets/juegos/memoria/cuadradito_widget.dart';
import '../../../../widgets/juegos/suma_resta/temporizador_widget.dart';

class MemoriaJuego extends StatefulWidget {
  final List<Cuadradito> cuadraditos;
  final void Function(int) onBuscandoPareja;
  final int casillasPorFila;
  final bool? estaEnDificil;

  const MemoriaJuego({
    super.key,
    required this.cuadraditos,
    required this.onBuscandoPareja,
    required this.casillasPorFila,
    this.estaEnDificil
  });

  @override
  State<MemoriaJuego> createState() => _MemoriaJuegoState();
}

class _MemoriaJuegoState extends State<MemoriaJuego> {
  final _temporizador = Temporizador(segundos: 0);
  String get _tiempo => _temporizador.segundos.toString();
  bool _detener = false;

  @override
  void initState() {
    super.initState();
    _cuentaRegresivaSiEstaEnDificil();
  }

  void _cuentaRegresivaSiEstaEnDificil(){
    if(widget.estaEnDificil!){
      _temporizador.activarCronometro(setState: setState, mounted: () => mounted && !_detener);
    }
  }

  void detenerTemporizador() {
    setState(() {
      _detener = true;
    });
  }

  void _finDelJuego()async{
    if(widget.estaEnDificil!){
      for(Cuadradito cuadradito in widget.cuadraditos){
        if(!cuadradito.destapado){
          return;
        }
      }
      final puntajeController = PuntajeController();

      detenerTemporizador();
      await puntajeController.asignarPuntos(5, int.parse(_tiempo));

    }
  }

  @override
  Widget build(BuildContext context) {
    final double anchoMaximo = MediaQuery.of(context).size.width;
    final double altoMaximo = MediaQuery.of(context).size.height;
    final double promedio = (altoMaximo + anchoMaximo) / 2;

    return Scaffold(
      appBar: AppBar(
        title: widget.estaEnDificil! ? temporizadorWidget(unidadMedida: promedio, leyendaTiempo: _tiempo) : null,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 20),
          color: Colors.blueAccent
        ),
        child: GridView.count(
          crossAxisCount: widget.casillasPorFila,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          children: List.generate(widget.cuadraditos.length, (i){
            return cuadraditoWidget(
              onClickCuadradito: () { 
                widget.onBuscandoPareja(i);
                _finDelJuego();
              },
              img: widget.cuadraditos[i].destapado ? widget.cuadraditos[i].img : 'https://i.imgur.com/fYJJwe4.png'
            );
          })
        ),
      ),
      
    );
  }
}