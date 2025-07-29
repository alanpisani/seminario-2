import 'package:flutter/material.dart';
import '../utils/general/reproductor.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  double _opacidad = 0;
  String _textoDinamico = 'Alan presenta';


  @override
  void initState() {
    super.initState();
    _iniciarIntro();
  }

  void _iniciarIntro() async {
    await Reproductor().reproducirSonidoEnLoop('sounds/intro.mp3');

    await _editarOpacidad(duracionSegundos: 3, opacidad: 1);
    await _editarOpacidad(duracionSegundos: 3, opacidad: 0);

    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _textoDinamico = 'Una producción hecha en flutter';
    });

    await _editarOpacidad(duracionSegundos: 2, opacidad: 1);
    await _editarOpacidad(duracionSegundos: 2, opacidad: 0);

    await Future.delayed(Duration(seconds: 1));
    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  Future<void> _editarOpacidad({required int duracionSegundos, required double opacidad})async{
    await Future.delayed(Duration(seconds: duracionSegundos));
      if (!mounted) return;
      setState(() {
        _opacidad = opacidad;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: AnimatedOpacity(
            opacity: _opacidad, 
            duration: Duration(seconds: 1),
            child: Text(_textoDinamico),
          )
        ),
      )
    );
  }
}