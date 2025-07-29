import 'package:flutter/material.dart';

Widget respuestaContainer({required double promedio, required String pista}){
  return Padding(
    padding: EdgeInsets.all(promedio * 0.05),
    child: AnimatedSwitcher(duration: Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) => 
        ScaleTransition(scale: animation, child: child,),
      child: Text(pista,
        key: ValueKey(pista),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.teal,
          fontSize: promedio * 0.05,
          fontWeight: FontWeight.bold
        ),
      ),
    )
  );
}