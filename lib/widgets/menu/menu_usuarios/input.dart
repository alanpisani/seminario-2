import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String label;
  final bool? obscureText;
  final TextEditingController controller;

  const Input({
    super.key,
    required this.label,
    this.obscureText,
    required this.controller
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return TextField(
    controller: widget.controller,
    obscureText: widget.obscureText ?? false,
    style: TextStyle(
      color: ColorScheme.of(context).primary
    ),
    decoration: InputDecoration(
      label: Text(widget.label,
        style:TextStyle(
          color: ColorScheme.of(context).primary
        )
      ),
    ),
  );
  }
}