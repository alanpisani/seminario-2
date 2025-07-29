// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../utils/general/reproductor.dart';
import '../../utils/logic/usuarios/sesionador.dart';
import '../../utils/logic/usuarios/validador.dart';
import '../../widgets/menu/menu_usuarios/formulario.dart';
import '../../widgets/menu/menu_usuarios/input.dart';
import '../../utils/general/alerts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _validador = Validador();

  Future<void> _conectarse() async {
    String? respuesta = await _validador.validarCredencialesLogin();
    
    if(respuesta != null){
      alerta(context, respuesta);
    }
    else{
      int id = _validador.getUsuarioValidadoLogin!.idUsersAlan!;
      await Sesionador.setearId(id);
      await Reproductor().detener();
      Navigator.pushNamed(context, '/home');
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
          inputs: [
            Input(label: "Nombre de usuario", controller: _validador.getNombreController),
            Input(label: "Contraseña", controller: _validador.getPassController, obscureText: true),
          ], 
          titulo: "Iniciar sesión", 
          onBoton: _conectarse,
          leyendaBoton: "Iniciar sesión",
          botonInhabilitado: null,
        ),
      )
    );
  }
}