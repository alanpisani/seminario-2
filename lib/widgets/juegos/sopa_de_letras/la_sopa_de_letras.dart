import 'package:flutter/material.dart';
import '../../../utils/constants/consts_sopa_de_letras.dart';
import '../../../utils/logic/juegos/sopa_de_letras/casilla_sopa.dart';
import '../../../widgets/juegos/sopa_de_letras/casilla_sopa_widget.dart';

class LaSopaDeLetras extends StatefulWidget {
  final List<CasillaSopa> listaLetrasMezcladas;
  final void Function(int) onCLickLetra;
  
  const LaSopaDeLetras({
    super.key,
    required this.listaLetrasMezcladas,
    required this.onCLickLetra,
    
  });

  @override
  State<LaSopaDeLetras> createState() => _LaSopaDeLetrasState();
}

class _LaSopaDeLetrasState extends State<LaSopaDeLetras> {
  @override
  Widget build(BuildContext context) {
    final double anchoMaximo = MediaQuery.of(context).size.width;
    final double altoMaximo = MediaQuery.of(context).size.height;
    final double promedio = (anchoMaximo + altoMaximo) / 2;

    return Container(
      color: Colors.deepPurple,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: promedio * 0.002),
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        crossAxisCount: dimensionSopa,
        shrinkWrap: true,
        children: List.generate(widget.listaLetrasMezcladas.length, (int i){
          return CasillaSopaWidget(
            letra: widget.listaLetrasMezcladas[i].letra, 
            color: widget.listaLetrasMezcladas[i].color,
            onCLickLetra: widget.onCLickLetra,
            indice: i,
          );
        })
      ),
    );
  }
}