import 'package:flutter/material.dart';

Future<bool?> alertaSolicitudVolverAJugar(BuildContext context, String titulo) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo, textAlign: TextAlign.center),
        content: Text('¿Querés volver a intentar?', textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Si",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("No",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ],
      );
    },
  );
}