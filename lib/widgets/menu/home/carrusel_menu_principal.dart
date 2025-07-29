import 'package:flutter/material.dart';
import '/utils/constants/consts_home.dart';
import '/utils/general/medidor_pantalla.dart';
import '/widgets/menu/home/boton_home.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CarruselMenuPrincipal extends StatelessWidget {
  final VoidCallback irASeccionJuegos;
  final void Function(VisibilityInfo, double, int) controlarVisibilidadDescripcion;

  const CarruselMenuPrincipal({
    super.key,
    required this.irASeccionJuegos,
    required this.controlarVisibilidadDescripcion
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MedidorPantalla.getAltoMaximo(context) * 0.4,
      decoration: BoxDecoration(
        color: Colors.pink,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(0, 3)
          ),
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(0, -3)
          )
        ]
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: rutasHome.length,
        itemBuilder: (context, int i){
          return VisibilityDetector(
            key: Key('boton-$i'),
            onVisibilityChanged: (info) => controlarVisibilidadDescripcion(info, 0.8, i),
            child: BotonHome(
              esSeccionJuegos: i == 0,
              esExit: i == rutasHome.length - 1,
              funcionIrASeccionJuegos: () => irASeccionJuegos(),
              ruta: rutasHome[i], 
              titulo: titulosHome[i], 
              img: imagenesHome[i], 
              color: coloresHome[i]
            )
          );
        }
      ),
    );
  }
}