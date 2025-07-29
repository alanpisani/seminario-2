import 'package:flutter/widgets.dart';

class MedidorPantalla {


  static double getAltoMaximo(BuildContext context) => MediaQuery.of(context).size.height;
  static double getAnchoMaximo(BuildContext context) => MediaQuery.of(context).size.width;
  static double getPromedio(BuildContext context) => (getAltoMaximo(context) + getAnchoMaximo(context)) / 2;
}