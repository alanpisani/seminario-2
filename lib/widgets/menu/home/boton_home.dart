import 'dart:io';

import 'package:flutter/material.dart';
import '../../../utils/general/alerts.dart';

class BotonHome extends StatefulWidget {
  final bool esSeccionJuegos;
  final bool esExit;
  final Function()? funcionIrASeccionJuegos;
  final String ruta;
  final String titulo;
  final String img;
  final Color color;

  const BotonHome({
    super.key,
    required this.esSeccionJuegos,
    required this.esExit, 
    this.funcionIrASeccionJuegos,
    required this.ruta, 
    required this.titulo,
    required this.img,
    required this.color
  });

  @override
  State<BotonHome> createState() => _BotonHomeState();
}

class _BotonHomeState extends State<BotonHome> {
  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double maxHeight = MediaQuery.of(context).size.height;
    final double promedio = (maxWidth + maxHeight) / 2;

    return GestureDetector(
      onTap: () {
        if(widget.esSeccionJuegos) {
          widget.funcionIrASeccionJuegos!();
        }
        else if(widget.esExit){
          exit(0);
        }
        else{
          try{
            Navigator.pushNamed(context, widget.ruta);
          }
          catch(e){
            alerta(context, 'La sección ${widget.titulo} no está disponible por el momento');
          }
        } 
      },
      child: Container(
        margin: EdgeInsets.all(promedio * 0.025),
        width: maxWidth * 0.6,
        decoration: BoxDecoration(
          border: Border.all(color: widget.color, width: 10),
          borderRadius: BorderRadius.circular(promedio * 0.04),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 3
            )
          ],
          image: DecorationImage(
            image: AssetImage('assets/img/menu_principal/${widget.img}'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.transparent.withAlpha(70),
              BlendMode.dstATop,
            ),
          )
        ),
        child: Center(
          child: Text(widget.titulo,
            style: TextStyle(
              fontSize: promedio * 0.04,
              fontFamily: "OptimusPrinceps"
            ),
          ),
        )
      ),
    );
  }
}