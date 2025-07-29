import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/puntaje_model.dart';

class PuntajeService {
  final String baseUrl = 'https://api.awspaints.com.ar/index.php';

  Future<List<Puntaje>?> getAllPuntajes()async{
    final response = await http.get(Uri.parse('$baseUrl/user_juegos_alan'));

    if(response.statusCode == 200){
      List<dynamic> puntajesMap= jsonDecode(response.body);
      List<Puntaje> puntajes = puntajesMap.map((puntajeMap) => Puntaje.fromMap(puntajeMap)).toList();

      return puntajes;
    }
    return null;
  }

  Future<Puntaje?> getPuntajeById(int id)async{
    final response = await http.get(Uri.parse('$baseUrl/user_juegos_alan/$id'));

    if(response.statusCode == 200){
      dynamic puntajeMap = jsonDecode(response.body);
      Puntaje puntaje = Puntaje.fromMap(puntajeMap);
      return puntaje;
    }
    return null;
  }

  Future<void> postPuntaje(Puntaje puntaje)async{
    try{
      await http.post(Uri.parse('$baseUrl/user_juegos_alan'),
        body: jsonEncode(puntaje.toMap())
      );
    }
    catch(error){
      throw Exception("No se pudo. Error: $error");
    }
  }

  Future<void> putPuntaje(Puntaje puntaje, int id)async{
    try{
      await http.put(Uri.parse('$baseUrl/user_juegos_alan/$id'),
        body: jsonEncode(puntaje.toMap())
      );
    }catch(error){
      throw Exception("No se pudo editar el puntaje. Error: $error");
    }
  }
}