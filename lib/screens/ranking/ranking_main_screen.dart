import 'package:flutter/material.dart';
import '../../utils/general/medidor_pantalla.dart';
import '../../screens/ranking/ranking.dart';
import '../../utils/logic/ranking/gestor_ranking.dart';

class RankingMainScreen extends StatefulWidget {
  const RankingMainScreen({super.key});

  @override
  State<RankingMainScreen> createState() => _RankingMainScreenState();
}

class _RankingMainScreenState extends State<RankingMainScreen> {
  List<String> _nombresBtn = [];
  int? _juegoSeleccionado;
  Key _keyParaRanking = UniqueKey();

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    List<String> nombres = await GestorRanking().traerNombreJuegos();
    setState(() {
      _nombresBtn = nombres;
    });
  }

  void _elegirRanking(int? nuevoRanking){
    if (nuevoRanking != null) {
      setState(() {
        _juegoSeleccionado = nuevoRanking;
        _keyParaRanking = UniqueKey();
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MedidorPantalla.getAltoMaximo(context) * 0.15,
            child: Text("Rankings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            ),
          ),
          DropdownButton(
            hint: Text("Seleccioná un juego"),
            value: _juegoSeleccionado,
            items: List.generate(_nombresBtn.length, (i) {
              return DropdownMenuItem(
                value: i,
                child: Text(_nombresBtn[i]),
              );
            }),
            onChanged: (int? nuevoRanking) => _elegirRanking(nuevoRanking)
          ),
          Expanded(
            child: _juegoSeleccionado != null ? Ranking(rankingLlamado: _juegoSeleccionado!, key: _keyParaRanking) : SizedBox()
          )
        ],
      ),
    ),
  );
}
}