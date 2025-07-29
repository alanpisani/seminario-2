import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/juego_model.dart';

class JuegoService {
  final String baseUrl = 'https://api.awspaints.com.ar/index.php';

  Future<List<Juego>> getAllJuegos()async{
    final response = await http.get(Uri.parse('$baseUrl/juegos_alan'));

    if(response.statusCode == 200){
      List<dynamic> juegosMap = jsonDecode(response.body);
      List<Juego> juegos = juegosMap.map((juego) => Juego.fromMap(juego)).toList();
      return juegos;
    }
    throw Exception("No se pudieron traer los juegos");
  }

  Future<Juego> getJuegoById(int id)async{
    final response = await http.get(Uri.parse('$baseUrl/juegos_alan/$id'));

    if(response.statusCode == 200){
      dynamic juegoMap = jsonDecode(response.body);
      Juego juego = Juego.fromMap(juegoMap);
      return juego;
    }
    throw Exception("No se pudo traer el juego");
  }
}