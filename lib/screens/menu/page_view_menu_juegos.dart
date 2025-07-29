import 'package:flutter/material.dart';
import 'home.dart';
import '../../screens/menu/seccion_juegos.dart';

class PageViewMenuJuegos extends StatefulWidget {
  const PageViewMenuJuegos({super.key});

  @override
  State<PageViewMenuJuegos> createState() => _PageViewMenuJuegosState();
}

class _PageViewMenuJuegosState extends State<PageViewMenuJuegos> {
  final _controller = PageController();

  void _pasarPagina(int pagina){
    _controller.animateToPage(
      pagina, 
      duration: Duration(seconds: 1), 
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Home(irASeccionJuegos: () => _pasarPagina(1)),
        SeccionJuegos(volverAMenuPrincipal: () => _pasarPagina(0))
      ],
    );
  }
}