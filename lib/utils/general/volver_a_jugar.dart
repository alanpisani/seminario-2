import 'package:flutter/material.dart';
import '../../utils/general/reproductor.dart';
import '../../widgets/general/alerta_volver_a_intentar.dart';

Future<void> deseasVolverAJugar({required BuildContext context, required String leyenda, required VoidCallback onLoQueHaceSiAceptasSeguir})async{
  bool? volverAJugar = await alertaSolicitudVolverAJugar(context, leyenda);

  if (volverAJugar == true) {
    onLoQueHaceSiAceptasSeguir();
  }
  else{
    Reproductor().detener();
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/home');
  }
}