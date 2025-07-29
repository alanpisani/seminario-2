import 'package:flutter/material.dart';
import '/widgets/menu/home/carrusel_menu_principal.dart';
import '../../utils/general/medidor_pantalla.dart';
import '../../widgets/menu/home/cartel_abajo_home.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../utils/general/reproductor.dart';
import '../../utils/logic/usuarios/sesionador.dart';
import '../../controllers/usuario_controller.dart';
import '../../models/usuario_model.dart';

class Home extends StatefulWidget {
  final VoidCallback irASeccionJuegos;
  const Home({super.key, required this.irASeccionJuegos});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = UsuarioController();
  String _nombreUsuario = '';
  int _i = 0;
  
  @override
  void initState() {
    super.initState();
    cargarUsuario();
  }

  Future<void> cargarUsuario() async{
    int? id = await Sesionador.retornarId();
    if (!mounted) return;

    Usuario? usuario = await _controller.traerUsuarioPorId(id);
    if (!mounted) return;

    setState(() {
      _nombreUsuario = usuario != null ? usuario.nombreUsersAlan : "Un extraño ser";
    });
  }

  Future<void> cerrarSesion() async{
    await Reproductor().detener();
    await Sesionador.resetearId();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/intro', (route) => false);
    }
  }

  void _controlarVisibilidadDescripcion(VisibilityInfo info, double visibilidadDelBoton, int indice){
    if (info.visibleFraction > visibilidadDelBoton) {
      setState(() {
        _i = indice;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          
        ),
        endDrawer: Drawer(
          backgroundColor: ColorScheme.of(context).onPrimary,
          child: Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text("SEMINARIO"),
                )   
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red,),
                title: Text("Cerrar sesión"),
                subtitle: Text(_nombreUsuario),
                onTap: () => cerrarSesion(),
              )
            ],
          )
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [ColorScheme.of(context).primary, Colors.purple],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SizedBox(
            height: MedidorPantalla.getAltoMaximo(context) * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Menú Principal",
                  style: TextStyle(
                    fontSize: MedidorPantalla.getPromedio(context) * 0.05,
                      fontFamily: "OptimusPrinceps",
                      fontWeight: FontWeight.bold,
                  ),
                ),
                CarruselMenuPrincipal(
                  irASeccionJuegos: widget.irASeccionJuegos, 
                  controlarVisibilidadDescripcion: _controlarVisibilidadDescripcion
                ),
                CartelAbajoHome(indice: _i)
              ],
            )
          ),
        ),
      )
    );
  }
}