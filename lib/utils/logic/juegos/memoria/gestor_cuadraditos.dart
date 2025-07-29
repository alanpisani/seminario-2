import 'dart:math';

import 'cuadradito.dart';

class GestorCuadraditos {
  final List<int> _nivelesMemoria = [12, 18, 24];
  int dificultad;
  final List<String> _dificultadesTxt = ['Facil', 'Normal', 'Dificil'];
  late List<Cuadradito> cuadraditos = List.generate(_nivelesMemoria[dificultad], (i){
   return Cuadradito(id: i % 2 == 1 
      ? i - 1 
      : i);
  });
  final List<String> imagenesCuadraditos = [
    'https://i.imgur.com/WawrR7C.jpg', //MESSI
    'https://i.imgur.com/8PrPT85.jpg', //PARAAAA
    'https://i.imgur.com/ZQjij5v.jpg', // YETI
    'https://i.imgur.com/88GdyS6.jpg', //BURNS
    'https://i.imgur.com/ZaKQXou.jpg', //PACHU
    'https://i.imgur.com/qNdBlj0.jpg', //GALLO CLAUDIO
    'https://i.imgur.com/8Aedsf6.jpg', //Marikaa
    'https://i.imgur.com/aB2ymsW.png', //Pato lucas
    'https://i.imgur.com/YAU0MNP.jpg', //Maradona
    'https://i.imgur.com/lpKn8zU.png', //Tijera
    'https://i.imgur.com/YSbtFFX.png', //Bart
    'https://i.imgur.com/WXMgWoK.jpg', //Spiderman
  ];

  GestorCuadraditos({
    required this.dificultad,
  });

  void _llenarCuadraditosConImagenes(){
    int j=0, idCuadradito=0;

    for(int i=0;i<cuadraditos.length;i++){
      if(cuadraditos[i].id == idCuadradito){
        cuadraditos[i].img = imagenesCuadraditos[j];
      }else{
        j++;
        cuadraditos[i].img = imagenesCuadraditos[j];
        idCuadradito += 2;
      }
    }
  }

  List<Cuadradito> _mezclarCuadraditos(){
    _llenarCuadraditosConImagenes();
    List<Cuadradito> cuadraditosMezclados = [];
    
    var random = Random();
    int num = 0;

    while(cuadraditosMezclados.length != cuadraditos.length){
      num = random.nextInt(cuadraditos.length);
      if(!cuadraditosMezclados.contains(cuadraditos[num])){
        cuadraditosMezclados.add(cuadraditos[num]);
      }
    }

    return cuadraditosMezclados;
  }

  List<Cuadradito> getCuadraditos(){
    return _mezclarCuadraditos();
  }

  List<String> getDificultadesTxt(){
    return _dificultadesTxt;
  }

  void _taparTodosLosCuadraditos(){
    for(Cuadradito cuadradito in cuadraditos){
      cuadradito.destapado = false;
      cuadradito.presionable = true;
    }
  }

  List<Cuadradito> mezclarYtaparCuadraditos(){
    _taparTodosLosCuadraditos();
    return getCuadraditos();
  }
}