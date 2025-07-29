import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario_model.dart';

class UsuarioService {
  final String baseUrl = "https://api.awspaints.com.ar/index.php";

  Future<void> postUsuario(Usuario usuario) async {
    //Map<String, dynamic> usuarioMapeado = usuario.toJson();
    try {
      await http.post(
        Uri.parse('$baseUrl/usersAlan'), //El endpoint
        body: jsonEncode(usuario.toMap()), //El encode. Manda body
      );
    } 
    catch (e) {
      throw Exception('No se pudo crear usuario: $e');
    }
  }

  Future<List<Usuario>> getUsuarios() async{
    try{
      final response = await http.get(Uri.parse('$baseUrl/usersAlan')); 

      if(response.statusCode == 200){
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Usuario> usuarios = jsonResponse.map((cadaUsuarioJson) => Usuario.fromMap(cadaUsuarioJson)).toList();
        return usuarios;
      }
      throw Exception("No se pudo armar la lista de usuarios");
      
    }catch(error){
      throw Exception('No se pudieron traer usuarios: $error');
    }
  }

  Future<Usuario> getUsuarioPorId(int? id) async{
    try{
      final response = await http.get(Uri.parse('$baseUrl/usersAlan/$id'));

      if(response.statusCode == 200){
        final jsonDecodeado = jsonDecode(response.body);
        
        if(jsonDecodeado is List){
          return Usuario.fromMap(jsonDecodeado[0]);
        }
        else if (jsonDecodeado is Map<String, dynamic>){
          return Usuario.fromMap(jsonDecodeado);
        }
        //return Usuario.fromMap(jsonDecodeado is List ? jsonDecodeado[0] : jsonDecodeado);
      }
      throw Exception("No se pudo armar el usuario");
    }
    catch(error){
      throw Exception('No se pudo traer el usuario: $error');
    }
  }
}
