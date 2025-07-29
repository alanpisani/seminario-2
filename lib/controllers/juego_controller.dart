import '../models/juego_model.dart';
import '../services/juego_service.dart';

class JuegoController {
  final service = JuegoService();

  Future<List<Juego>> traerJuegos()async{
    List<Juego> juegos = await service.getAllJuegos();

    return juegos;
  }

  Future<Juego> traerJuegoPorId(int id)async{
    Juego juego = await service.getJuegoById(id);

    return juego;
  }
}