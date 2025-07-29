class Marcador {
  int contTotales = 0;
  int contConsecutivas = 0;

  void incrementarContadores(){
    contTotales++;
    contConsecutivas++;
  }

  void reiniciarContConsecutivas(){
    contConsecutivas = 0;
  }

  void reiniciarTodosLosContadores(){
    contTotales = 0;
    reiniciarContConsecutivas();
  }
}