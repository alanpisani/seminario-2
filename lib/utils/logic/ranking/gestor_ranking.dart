import '../../../controllers/juego_controller.dart';
import '../../../controllers/puntaje_controller.dart';
import '../../../controllers/usuario_controller.dart';
import '../../../models/juego_model.dart';
import '../../../models/puntaje_model.dart';
import '../../../models/usuario_model.dart';

class GestorRanking {
  final _juegoController = JuegoController();
  final _puntajesController = PuntajeController();
  final _userController = UsuarioController();
  final List<String> txtColumnasRanking = ['Duelos ganados', 'Victorias', 'Cuentas resueltas', 'Segundos', 'Victorias', "Segundos", "Palabras correctas"];

  Future<List<String>> traerNombreJuegos()async{
    List<Juego> juegos = await _juegoController.traerJuegos();
    List<String> nombreJuegos = juegos.map((juego) => juego.tituloJuego).toList();
    return nombreJuegos;
  }

  Future<List<Puntaje>> traerPuntajesPorJuego(int idJuego)async{
    List<Puntaje> puntajes = [];
    List<Puntaje> todosLosPuntajes = await _puntajesController.traerTodosLosPuntajes();
    for(Puntaje puntaje in todosLosPuntajes){
      if(puntaje.idJuego == idJuego){
        puntajes.add(puntaje);
      }
    }

    return puntajes;   
    
  }

  List<Puntaje> traerListaOrdenadaPuntajes(List<Puntaje> puntajes, int indiceJuego){
    if(indiceJuego == 3 || indiceJuego == 5){
      puntajes.sort((a, b) => a.puntajeUserJuego.compareTo(b.puntajeUserJuego));
    }
    else{
      puntajes.sort((a, b) => b.puntajeUserJuego.compareTo(a.puntajeUserJuego));
    }

    return puntajes;
  }

  Future<List<String>> traerNombresJugadores(List<Puntaje> puntajes)async{
    List<String> nombres = [];
    for(Puntaje puntaje in puntajes){
      Usuario? usuario = await _userController.traerUsuarioPorId(puntaje.idUser);
      nombres.add(usuario!.nombreUsersAlan);
    }

    return nombres;
  }

}