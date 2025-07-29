import 'package:flutter/material.dart';
import '../../widgets/menu/menu_usuarios/boton_menu_usuario.dart';
import '../../widgets/general/texto_opacidad_animada.dart';
import '../../screens/usuario/login.dart';
import '../../screens/usuario/registro.dart';

class MenuUsuario extends StatefulWidget {
  const MenuUsuario({super.key});

  @override
  State<MenuUsuario> createState() => _MenuUsuarioState();
}

class _MenuUsuarioState extends State<MenuUsuario> {
  double _opacidadParteDos = 0;
  double _opacidadSeminario = 0;
  
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _opacidadSeminario = 1;
      });
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _opacidadParteDos = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [ColorScheme.of(context).onPrimary, ColorScheme.of(context).onPrimary, Color.fromARGB(255, 13, 0, 36)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            )
          ),
          child: Center(
            child: SizedBox(
              height: maxHeight * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      TextoOpacidadAnimada(
                        texto: "Seminario", 
                        opacidad: _opacidadSeminario, 
                        duracionMilisegundos: 1500, 
                        porcentajeTamFuente: 0.1,),
                      TextoOpacidadAnimada(
                        texto: "Parte 2", 
                        opacidad: _opacidadParteDos, 
                        duracionMilisegundos: 2000, 
                        porcentajeTamFuente: 0.035,)
                    ],
                  ),
                  SizedBox(
                    height: maxHeight * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BotonMenuUsuario(label: "Ingresar", widgetADirigirse: Login()),
                        BotonMenuUsuario(label: "Creá tu cuenta", widgetADirigirse: Registro()),
                      ],
                    ),
                  ),
                  Text('Versión 0.6.1')
                ],
              ),
            ),
          ),
        )
      ) 
    );
  }
}