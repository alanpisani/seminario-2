import 'package:flutter/material.dart';
import '../../utils/general/medidor_pantalla.dart';

class TextoOpacidadAnimada extends StatefulWidget {
  final String texto;
  final double opacidad;
  final int duracionMilisegundos;
  final double? porcentajeTamFuente;

  const TextoOpacidadAnimada({
    super.key,
    required this.texto,
    required this.opacidad,
    required this.duracionMilisegundos,
    this.porcentajeTamFuente
    
  });

  @override
  State<TextoOpacidadAnimada> createState() => _TextoOpacidadAnimadaState();
}

class _TextoOpacidadAnimadaState extends State<TextoOpacidadAnimada> {
  @override
  Widget build(BuildContext context) {
    final double promedio = MedidorPantalla.getPromedio(context);

    return AnimatedOpacity(
      opacity: widget.opacidad, 
      duration: Duration(milliseconds: widget.duracionMilisegundos),
      child: Text(widget.texto,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: widget.porcentajeTamFuente != null ? promedio * widget.porcentajeTamFuente! : null,
          fontWeight: FontWeight.bold,
          fontFamily: "OptimusPrinceps",
        ),
      ),
    );
  }
}