import 'package:flutter/material.dart';
import '../../../utils/logic/juegos/tateti/casilla.dart';

Widget matrizWidget({required double alturaMaxima, required void Function(int) onEjecutarJugada, required List<Casilla> listaCasillas }){
  return SizedBox(
    height: alturaMaxima * 0.6,
    child:  GridView.count(
      crossAxisCount: 3,
      children: List.generate(9, (index){
        return GestureDetector(
          onTap: () => onEjecutarJugada(index),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                FadeTransition(opacity: animation, child: child),
            child: Container(
              key: ValueKey(listaCasillas[index].esCruz),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal),
                image: listaCasillas[index].esCruz != null
                    ? DecorationImage(
                      image: NetworkImage(
                        listaCasillas[index].esCruz == true
                            ? 'https://i.imgur.com/xLPimrd.png'
                            : 'https://i.imgur.com/tsdSHJq.png',
                        ),
                      )
                    : null,
              ),
            ),
          ),
        );
      }),
    ),
  );
}