import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget inputContainer({required double anchoMaximo, required TextEditingController inputController, required FocusNode focusNode, required void Function() onRespuesta, required bool enabled}){
  return SizedBox(
    width: anchoMaximo * 0.2,
    child: TextField(
      enabled: enabled,
      controller: inputController,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      onSubmitted: (String _) => onRespuesta(),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purpleAccent, width: 1)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 3)
        ),
      ),
    ),
  );
}