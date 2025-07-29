import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/asignacion_model.dart';

class AsignacionService {
  final String baseUrl = 'https://api.awspaints.com.ar/index.php';

  Future<List<Asignacion>> getAsignaciones() async{
    try{
      final response = await http.get(Uri.parse('$baseUrl/logroUsersAlan'));

      if(response.statusCode == 200){
        List<dynamic> responseMapeado = jsonDecode(response.body);
        List<Asignacion> asignaciones = responseMapeado.map( (asignacionMap) => Asignacion.fromMap(asignacionMap) ).toList();
        return asignaciones;
      }
      throw Exception("Hubo un error al consumir la api");
    }
    catch(error){
      throw Exception("No se pudieron obtener las asignaciones: $error");
    }
  }

  Future<List<Asignacion>> getAsignacionPorUserId(int idUser) async{
    try{
      final response = await http.get(Uri.parse('$baseUrl/logroUsersAlan/$idUser'));

      if(response.statusCode== 200){
        final List<dynamic> responseDecodeado = jsonDecode(response.body);
        final List<Asignacion> asignacionesDelUsuario = responseDecodeado.map( (asignacionMap) => Asignacion.fromMap(asignacionMap) ).toList();

        return asignacionesDelUsuario;
      }
      throw Exception("Tipo de dato mal hecho o algo asi");
        
    }
    catch(error){
      throw Exception("No se pudo obtener la asignacion: $error");
    }
  }

  Future<void> postAsignacion(int idUser, int idLogro) async{
    Map<String, dynamic> asignacion = {
      'id_user': idUser,
      'id_logro': idLogro
    };

    try{
      await http.post(
        Uri.parse('$baseUrl/logroUsersAlan'),
        body: jsonEncode(asignacion)
      );
    }
    catch(error){
      throw Exception("No se pudo asignar logro a usuario: $error");
    }
  }
}