import 'package:flutter/material.dart';

Widget cuadraditoWidget({required VoidCallback onClickCuadradito, required String img}){
  return GestureDetector(
    onTap: onClickCuadradito,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color:Colors.black, width: 2),
        boxShadow: [
          BoxShadow(offset: Offset(3, 3), blurRadius: 3)
        ],
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.cover
        )
      ),
    )
  );
}