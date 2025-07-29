import 'package:flutter/material.dart';

Widget marcadorContainer(int contador){
  return Container(
    color: Colors.pink,
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right:50),
    child: Text('$contador',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17
      ),
    ),
  );
}