import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget inputWidget({required double unidadMedida, required bool estaDisponible, required TextEditingController textEditingController, required FocusNode focusNode, required void Function() funcionGeneradoraCuentas}){
  return Padding(
    padding: EdgeInsets.all(unidadMedida * 0.02),
    child: TextField(
      enabled: estaDisponible,
      controller: textEditingController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onSubmitted: (String _) => funcionGeneradoraCuentas(),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white70)
        )
      ),
    ),
  );
}