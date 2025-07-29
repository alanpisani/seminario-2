import 'package:flutter/material.dart';
import '../../widgets/ranking/texto_tabla.dart';

class FilaTabla extends StatefulWidget {
  final String puesto;
  final String nombreUsuario;
  final String puntuacion;
  final Color color;

  const FilaTabla({
    super.key,
    required this.puesto,
    required this.nombreUsuario,
    required this.puntuacion,
    required this.color
  });

  @override
  State<FilaTabla> createState() => _FilaTablaState();
}

class _FilaTablaState extends State<FilaTabla> {
  @override
  Widget build(BuildContext context) {
    final double altoMaximo = MediaQuery.of(context).size.height;

    return Container(
      height: altoMaximo * 0.075,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border(
          bottom: BorderSide(
            color: Colors.blueGrey,
            width: 5
          )
        )
      ),
      child: Row(
        children: [
          textoTabla(flex: 1, texto: widget.puesto),
          textoTabla(flex: 1, texto: widget.nombreUsuario),
          textoTabla(flex: 1, texto: widget.puntuacion),
        ],
      ),
    );
  }
}