import 'package:flutter/material.dart';

Widget eleccionContainer(double maxWidth, double maxHeight, String url, String quien, bool alineamientoIzq){
  return Padding(
    padding: EdgeInsets.only(left: 20),
    child: Row(
      mainAxisAlignment: alineamientoIzq ?  MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Text(quien,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
        SizedBox(
          width: maxWidth * 0.1,
        ),
        AnimatedSwitcher(duration: Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) => 
            ScaleTransition(scale: animation, child: child),
          child: Container(
            key: ValueKey(url),
            width: maxWidth * 0.3,
            height: maxHeight *0.2,
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.imgur.com/$url.png')
              )
            ),
          ),
        )
      ],
    ),
  );
}