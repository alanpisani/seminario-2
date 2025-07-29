import 'package:flutter/material.dart';

void alerta(BuildContext context, String mensaje, {bool cuidado = true}){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(cuidado ? "Cuidado ❌" : "Éxito ✅",
            textAlign: TextAlign.center,
          ),
          content: Text(mensaje,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => cuidado ? Navigator.of(context).pop() : Navigator.pushNamed(context, '/'), 
              child: Text("Cerrar",
                style: TextStyle(
                  color: ColorScheme.of(context).tertiary
                ),
              )
            )
          ],
        );
      }
    );
  }