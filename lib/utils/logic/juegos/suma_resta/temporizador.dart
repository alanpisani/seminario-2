class Temporizador {
  int segundos;
  bool _detener = false;

  Temporizador({
    required this.segundos
  });

  void decrementarTiempo(){
    segundos--;
  }

  void incrementarTiempo(){
    segundos++;
  }

  void cuentaRegresiva({required Function(Function()) setState, required bool Function() mounted}){
    Future.delayed(Duration(seconds: 1),(){
      if(!mounted() || _detener == true) return;
      decrementarTiempo();
      setState(() {
        if(segundos > 0){
          cuentaRegresiva(setState: setState, mounted: mounted);
        }
      });
    });
  }

  void activarCronometro({required Function(Function()) setState, required bool Function() mounted}){
    Future.delayed(Duration(seconds: 1),(){
      if(!mounted() || _detener == true) return;
      incrementarTiempo();
      setState(() {
        
        if(segundos > 0){

          activarCronometro(setState: setState, mounted: mounted);
        }
        
      });
    });
  }

  void setearSegundos(int segundos){
    this.segundos = segundos;
  }

  void detenerCronometro(){
    _detener = true;
  }

  void reiniciarCronometro(){
    _detener = false;
  }
}