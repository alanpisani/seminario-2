import 'package:flutter/material.dart';

class GestorInput{
  final inputController = TextEditingController();
  final focusNode = FocusNode();
  bool _enabled = true;

  bool get getEnabled => _enabled;

  void limpiarYFocusearInput(){
    inputController.clear();
    focusNode.requestFocus();
  }

  void bloquearInput(){
    _enabled = false;
  }

  void habilitarInput(){
    _enabled = true;
  }
}