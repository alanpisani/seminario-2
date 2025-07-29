import 'package:shared_preferences/shared_preferences.dart';

class Sesionador {
  
  static Future<void> setearId(int id)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id_usuario', id);
  }

  static Future<int?> retornarId()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id_usuario');
  }

  static Future<void> resetearId()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('id_usuario', 0);
    await prefs.clear();
  }

  
}