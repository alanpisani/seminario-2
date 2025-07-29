import 'package:flutter/material.dart';
import '../../../utils/general/medidor_pantalla.dart';

class BotonMenuUsuario extends StatelessWidget {
  final String label;
  final Widget widgetADirigirse;
  const BotonMenuUsuario({
    super.key,
    required this.label,
    required this.widgetADirigirse
  });

  @override
  Widget build(BuildContext context) {
    double promedio = MedidorPantalla.getPromedio(context);

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => widgetADirigirse)), 
      child: Container(
        padding: EdgeInsets.all(promedio * 0.01),
        margin: EdgeInsets.all(promedio * 0.01),
        child: Text(label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: promedio * 0.05,
            fontFamily: "OptimusPrinceps"
          ),
        ),
      ),
    );
  }
}