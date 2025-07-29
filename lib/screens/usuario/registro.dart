// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../utils/logic/usuarios/validador.dart';
import '../../widgets/menu/menu_usuarios/formulario.dart';
import '../../widgets/menu/menu_usuarios/input.dart';
import '../../controllers/usuario_controller.dart';
import '../../utils/general/alerts.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final _validador = Validador();
  final _usuarioController = UsuarioController();
  bool _inhabilitarBoton = false;

  Future<void> _registrarse() async{
    setState(() {
      _inhabilitarBoton = true;
    });

    String? respuesta = await _validador.validarCredencialesRegistro();

    if(respuesta != null){
      alerta(context, respuesta);

      setState(() {
        _inhabilitarBoton = false;
      });

    }

    else{
      await _usuarioController.registrarUsuario(_validador.getUsuarioValidadoRegistro());
      alerta(context, "Registro exitoso", cuidado: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorScheme.of(context).onSecondary,
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        color: ColorScheme.of(context).onSecondary,
        child: Formulario(
          titulo: "Registro",
          inputs: [
            Input(label: "Nombre de usuario", controller: _validador.getNombreController),
            Input(label: "Contraseña", controller: _validador.getPassController, obscureText: true),
            Input(label: "Repetir contraseña", controller: _validador.getPassDosController, obscureText: true),
          ], 
          onBoton: _registrarse,
          leyendaBoton: "Registrarse",
          botonInhabilitado: _inhabilitarBoton,
        )
      ),
    );
  }
}