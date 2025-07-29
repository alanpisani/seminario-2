import 'dart:math';

class Cuenta {
  int numA = 1 + Random().nextInt(100);
  late int numB = 1 + Random().nextInt(numA);
  int operadorMatematico = Random().nextInt(2);
  late String operadorString =  operadorMatematico == 0 ? '+' : '-';


  String get cuentaGenerada => '$numA $operadorString $numB';

  int resolverCuenta() => operadorMatematico == 0 ? numA + numB : numA - numB; 

  bool respondisteBien({ required String tuRespuesta}) => resolverCuenta().toString() == tuRespuesta;

  void reasignarValores(){
    numA = 1 + Random().nextInt(100);
    numB = 1 + Random().nextInt(numA);
    operadorMatematico = Random().nextInt(2);
    operadorString =  operadorMatematico == 0 ? '+' : '-';
  }
}