import '../services/logro_service.dart';
import '../models/logro_model.dart';

class LogroController {
  final service = LogroService();

  Future<List<Logro>> traerLogros() async{
    final logros = await service.getLogros();

    return logros;

  }

  Future<Logro> traerLogroPorId(int id) async{
    final logro = await service.getLogroPorId(id);

    return logro;

  }
}