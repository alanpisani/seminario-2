import 'cuadradito.dart';

class MotorMemoria{
  int _intento = 0;
  bool _dificultadSeleccionada = false;
  Cuadradito _primerCuadradito = Cuadradito(id: 0);

  bool getDificultadSeleccionada(){
    return _dificultadSeleccionada;
  }
  
  void _incrementarIntento(){
    _intento++;
  }

  void _reiniciarIntento(){
    _intento = 0;
  }

  void _mostrarCuadradito(Cuadradito cuadradito){
    cuadradito.destapado = true;
    cuadradito.presionable = false;
  }

  void _ocultarCuadradito(Cuadradito cuadradito){
    cuadradito.destapado = false;
    cuadradito.presionable = true;
  }
  
  Future<bool> procesoEleccionCuadradito(int i, List<Cuadradito> listaCuadraditos, {required void Function(void Function()) setState}) async {
    _incrementarIntento();

    if(_intento == 1) {
      setState(() {
        _primerCuadradito = listaCuadraditos[i];
        _mostrarCuadradito(_primerCuadradito);
      });
      return false;
    } 
    else {
      Cuadradito segundo = listaCuadraditos[i];
      bool esPareja = _primerCuadradito.id == segundo.id;

      setState(() {
        _mostrarCuadradito(segundo);
      });

      if (!esPareja) {
        await Future.delayed(Duration(milliseconds: 250));
        setState(() {
          _ocultarCuadradito(_primerCuadradito);
          _ocultarCuadradito(segundo);
        });
      }

      _reiniciarIntento();
      return esPareja;
    }
  }

  void yaSeSeleccionoDificultad(){
    _dificultadSeleccionada = true;
  }
}