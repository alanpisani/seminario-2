import 'package:flutter/material.dart';
import '../../widgets/menu/home/boton_seccion_juegos.dart';
import '../../utils/constants/consts_seccion_juegos.dart';

class SeccionJuegos extends StatefulWidget {
  final VoidCallback volverAMenuPrincipal;
  const SeccionJuegos({super.key, required this.volverAMenuPrincipal});

  @override
  State<SeccionJuegos> createState() => _SeccionJuegosState();
}

class _SeccionJuegosState extends State<SeccionJuegos> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: IconButton(
            onPressed: widget.volverAMenuPrincipal, 
            icon: Icon(Icons.arrow_back)
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child:GridView.count(
            crossAxisCount: 2,
            children: List.generate(titulosSeccionJuegos.length, (int index){
              return BotonSeccionJuegos(
                indice: index,
              );
            })
          )
        ),
      )
    );
  }
}