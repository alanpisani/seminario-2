import 'package:flutter/material.dart';
import '../../models/puntaje_model.dart';
import '../../utils/logic/ranking/gestor_ranking.dart';
import '../../widgets/ranking/tabla.dart';

class Ranking extends StatefulWidget {
  final int rankingLlamado;
  const Ranking({
    super.key,
    required this.rankingLlamado,

  });

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  final _gestorRanking  = GestorRanking();
  final List<String> _columnas = GestorRanking().txtColumnasRanking;
  List<Puntaje> _lista = [];
  List<String> _listaNombre = [];
  bool _listaCargada = false;

  @override
  void initState() {
    super.initState();
    _inicializarTodo();
  }

  void _inicializarTodo()async{
    await _traerLista(widget.rankingLlamado + 2); //+2 porque el id del primer juego es 2 y el primer i es 0
    setState(() {
      _listaCargada = true;
    });
  }

  Future<void> _traerLista(int idJuego) async {
    _lista = await _gestorRanking.traerPuntajesPorJuego(idJuego);
    _lista = _gestorRanking.traerListaOrdenadaPuntajes(_lista, widget.rankingLlamado);
    _listaNombre = await _gestorRanking.traerNombresJugadores(_lista);
  }

  @override
  Widget build(BuildContext context) {

    if(!_listaCargada){
      return Scaffold(
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Cargando ranking. Esperá, por favor..."),
            CircularProgressIndicator(color: Colors.green,)
          ],
        ),
      ),
      );
    }

    return Scaffold(
      body: Tabla(
        tituloPuntaje: _columnas[widget.rankingLlamado], 
        listaDeNombres: _listaNombre, 
        listaDePuntuaciones: _lista
      )
    );
    
  }
}