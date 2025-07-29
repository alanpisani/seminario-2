import 'package:flutter/material.dart';
import '../../models/puntaje_model.dart';
import '../../widgets/ranking/filas_tabla.dart';
import '../../widgets/ranking/texto_tabla.dart';

class Tabla extends StatefulWidget {
  final String tituloPuntaje;
  final List<String> listaDeNombres;
  final List<Puntaje> listaDePuntuaciones;

  const Tabla({
    super.key,
    required this.tituloPuntaje,
    required this.listaDeNombres,
    required this.listaDePuntuaciones,
  });

  @override
  State<Tabla> createState() => _TablaState();
}

class _TablaState extends State<Tabla> {
  @override
  Widget build(BuildContext context) {
    final double anchoMaximo = MediaQuery.of(context).size.width;
    final double altoMaximo = MediaQuery.of(context).size.height;
    final double promedio = (altoMaximo + anchoMaximo) / 2;
    
    return Center(
      child: Container(
        margin: EdgeInsets.all(promedio * 0.03),
        width: anchoMaximo * 0.95,
        height: altoMaximo * 0.85,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 3, 71),
          borderRadius: BorderRadius.circular(promedio * 0.02),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 2
            )
          ]
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: promedio * 0.02, bottom: promedio * 0.02,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(promedio * 0.02),
              ),
              child: Row(
                children: [
                  textoTabla(flex: 1, texto: "Puesto", color: Colors.white70),
                  textoTabla(flex: 1, texto: "Usuario", color: Colors.white70),
                  textoTabla(flex: 1, texto: widget.tituloPuntaje, color: Colors.white70),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.listaDeNombres.length,
                itemBuilder: (context, int i){
                  return FilaTabla(
                    puesto: (i+1).toString(), 
                    nombreUsuario: widget.listaDeNombres[i], 
                    puntuacion: widget.listaDePuntuaciones[i].puntajeUserJuego.toString(), 
                    color: i == 0 ? Colors.green : Colors.white70
                  );
                }
              )
            )
          ],
        ),
      ),
    );
  }
}