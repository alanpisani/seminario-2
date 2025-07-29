import 'package:flutter/material.dart';
import '../../utils/general/medidor_pantalla.dart';
import '../../utils/general/reproductor.dart';
  
  void mostrarSnackbar(String mensaje, BuildContext context) {
    final double promedio = MedidorPantalla.getPromedio(context);

    final snackBar = SnackBar(
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.075,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/trophy.png")
            
                )
              ),
            ),
            Expanded(
              child: Text("¡Logro desbloqueado!\n$mensaje",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: promedio * 0.025,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      duration: const Duration(seconds: 1),
      backgroundColor: ColorScheme.of(context).primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(promedio * 0.03),
          topRight: Radius.circular(promedio * 0.03),
        )
      ),
      
    );

    Reproductor().reproducirSonido('sounds/logro.mp3');
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }