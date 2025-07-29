class GestorContadores {
  int _contador = 0;
  int _intentosHastaCambiar = 0;

  int get getContador => _contador;
  int get getIntentos => _intentosHastaCambiar;

  void incrementarContador(){
    _contador++;
  }

  void incrementarIntentos(){
    _intentosHastaCambiar++;
  }

  void reiniciarIntentos(){
    _intentosHastaCambiar = 0;
  }

  void reiniciarContadores(){
    _contador = 0;
    reiniciarIntentos();
  }

}