import 'package:flutter/material.dart';
import '../../../utils/constants/consts_seccion_juegos.dart';
import '../../../utils/general/medidor_pantalla.dart';

class BotonSeccionJuegos extends StatelessWidget {
  final int indice;
  const BotonSeccionJuegos({
    super.key,
    required this.indice
  
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, rutasSeccionJuegos[indice]),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 3),
          color: coloresSeccionJuegos[indice].withAlpha(150)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MedidorPantalla.getAltoMaximo(context) * 0.09,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/seccion_juegos/${imagenesSeccionJuegos[indice]}"),
                )         
              ),
            ),
            Container(
              width: double.infinity,
              height: MedidorPantalla.getAltoMaximo(context) * 0.07,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.green, coloresSeccionJuegos[indice]]),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MedidorPantalla.getPromedio(context) * 0.02),
                  topRight: Radius.circular(MedidorPantalla.getPromedio(context) * 0.02),
                )
              ),
              child: Center(
                child: Text(titulosSeccionJuegos[indice],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: MedidorPantalla.getPromedio(context) * 0.03,
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }
}