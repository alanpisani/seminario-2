import 'package:flutter/material.dart';
import '/utils/general/medidor_pantalla.dart';
import '/models/logro_model.dart';
import '/widgets/logro_widget.dart';

Widget mostradorDeLogros(BuildContext context, List<Logro> lista, bool desbloqueado, String txt){
  if(lista.isNotEmpty ){
    return Column(
      children: List.generate(lista.length, (int index){
        return logroWidget(
            contexto: context,
            texto: lista[index].nombreLogroAlan,
            descripcion: lista[index].descripcionLogroAlan,
            imgUrl: lista[index].urlLogroAlan,
            desbloqueado: desbloqueado
        );
      })
    );
  }
  return Card(
    color: Colors.purple,
    elevation: 10,
    child: Padding(
      padding: EdgeInsetsGeometry.all(MedidorPantalla.getPromedio(context) * 0.02),
      child: Text(txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: MedidorPantalla.getPromedio(context) * 0.03
        )
      ),
    )  
  );
}