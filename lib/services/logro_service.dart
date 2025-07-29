import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/logro_model.dart';

class LogroService {
  final String baseUrl = 'https://api.awspaints.com.ar/index.php';

  Future<List<Logro>> getLogros() async{
    try{
      final response = await http.get(Uri.parse('$baseUrl/logrosAlan'));

      if(response.statusCode == 200){
        List<dynamic> logrosMapa = jsonDecode(response.body);
        List<Logro> logros = logrosMapa.map((logroMapa) => Logro.fromMap(logroMapa)).toList();
        return logros;
      }
      throw Exception("No se pudo consumir api");
    }
    catch(error){
      throw Exception("No se pudo obtener los logros: $error");
    }
  }

  Future<Logro> getLogroPorId(int id) async{
    try{
      final response = await http.get(Uri.parse('$baseUrl/logrosAlan/$id'));

      if(response.statusCode == 200){
        Map<String, dynamic> logroMapa = jsonDecode(response.body);
        Logro logro = Logro.fromMap(logroMapa);
        return logro;
      }
      throw Exception("No se pudo consumir la api");
    }
    catch(error){
      throw Exception("No se pudo obtener el logro: $error");
    }
  }
}