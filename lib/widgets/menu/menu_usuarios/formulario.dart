import 'package:flutter/material.dart';
import '../../../utils/general/medidor_pantalla.dart';
import 'input.dart';

class Formulario extends StatefulWidget {
  final List<Input> inputs;
  final String titulo;
  final void Function() onBoton;
  final String leyendaBoton;
  final bool? botonInhabilitado;

  const Formulario({
    super.key,
    required this.inputs,
    required this.titulo,
    required this.onBoton,
    required this.leyendaBoton,
    required this.botonInhabilitado
  });

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {

  bool _elBotonEstaHabilitado(){
    return widget.botonInhabilitado == null || !widget.botonInhabilitado!;
  }

  @override
  Widget build(BuildContext context) {
    final double promedio = MedidorPantalla.getPromedio(context);

    return Container(
      height: MedidorPantalla.getAltoMaximo(context) * 0.75,
      padding: EdgeInsets.all(promedio * 0.05),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 250, 223),
        border: Border.all(color: ColorScheme.of(context).onPrimary),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(promedio * 0.05),
          topRight: Radius.circular(promedio * 0.05),
        )
      ),
      child: Column(
        
        children: [
          Text(widget.titulo,
            style: TextStyle(
              fontSize: promedio * 0.05,
              color: Colors.black
            )
          ),
          SizedBox(
            height: MedidorPantalla.getAltoMaximo(context) * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.inputs,
            ),
          ),
          ElevatedButton(
            onPressed: () => _elBotonEstaHabilitado() ? widget.onBoton() : null,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(ColorScheme.of(context).onSecondary)
            ),
            child: _elBotonEstaHabilitado() 
            ? Text(widget.leyendaBoton, style: TextStyle(color: Colors.white))
            : SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white),
              ),
            
          )
        ],
      )
    );
  }
}