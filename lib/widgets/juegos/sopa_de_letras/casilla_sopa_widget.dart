import 'package:flutter/material.dart';

class CasillaSopaWidget extends StatefulWidget {
  final String letra;
  final Color color;
  final int indice;
  final void Function(int) onCLickLetra;

  const CasillaSopaWidget({
    super.key,
    required this.letra,
    required this.color,
    required this.onCLickLetra,
    required this.indice
    });

  @override
  State<CasillaSopaWidget> createState() => _CasillaSopaWidgetState();
}

class _CasillaSopaWidgetState extends State<CasillaSopaWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onCLickLetra(widget.indice),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all()
        ),
        child: Text(widget.letra,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}