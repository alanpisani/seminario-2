import '../utils/logic/usuarios/sesionador.dart';

import '../models/puntaje_model.dart';
import '../services/puntaje_service.dart';

class PuntajeController {
  final service = PuntajeService();
  
  Future<List<Puntaje>> traerTodosLosPuntajes()async{
    List<Puntaje>? puntajes = await service.getAllPuntajes();

    if(puntajes != null){
      return puntajes;
    }
    return <Puntaje>[];
  }

  Future<Puntaje> _traerPuntajePorId(int id)async{
    Puntaje? puntaje = await service.getPuntajeById(id);

    if(puntaje != null) return puntaje;
    throw Exception("No se pudo");
  }

  Future<void> _agregarPuntos(int idJuego, int idUser, int valorPuntaje)async{
    Puntaje puntaje = Puntaje(
      idJuego: idJuego, 
      idUser: idUser, 
      puntajeUserJuego: valorPuntaje
    );

    await service.postPuntaje(puntaje);
  }

  Future<void> _actualizarPuntos(int id, int nuevoPuntaje)async{
    Puntaje puntaje = await _traerPuntajePorId(id);

    puntaje.puntajeUserJuego = nuevoPuntaje;
    await service.putPuntaje(puntaje, id);
  }

  Future<void> asignarPuntos(int idJuego, int valorPuntaje)async{
    int? idUsuario = await Sesionador.retornarId();
    Puntaje? puntajeDelUsuario = await traerPuntajeDeUsuario(idUsuario!, idJuego);

    if(puntajeDelUsuario == null){
      _agregarPuntos(idJuego, idUsuario, valorPuntaje);
    }
    else if((idJuego == 5 || idJuego == 7) && valorPuntaje < puntajeDelUsuario.puntajeUserJuego){
      _actualizarPuntos(puntajeDelUsuario.idUsersJuegos!, valorPuntaje);
    }
    else if((idJuego != 5 && idJuego != 7) && puntajeDelUsuario.puntajeUserJuego < valorPuntaje){
      _actualizarPuntos(puntajeDelUsuario.idUsersJuegos!, valorPuntaje);
    }
  }

  Future<Puntaje?> traerPuntajeDeUsuario(int idUser, int idJuego,)async{
    List<Puntaje> todosLosPuntajes = await traerTodosLosPuntajes();

    for(Puntaje puntaje in todosLosPuntajes){
      if(puntaje.idUser == idUser && puntaje.idJuego == idJuego){
        return puntaje;
      }
    }
    return null;
  }

  Future<int> traerValorPuntajeDeUsuario({required int idJuego})async{
    int? idUsuario = await Sesionador.retornarId();
    Puntaje? puntaje = await traerPuntajeDeUsuario(idUsuario!, idJuego);

    if(puntaje != null) return puntaje.puntajeUserJuego;
    return 0;

  }
}