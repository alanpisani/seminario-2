import '../models/usuario_model.dart';
import '../services/usuario_service.dart';

class UsuarioController {
  final service = UsuarioService();

  Future<void> registrarUsuario(Usuario usuario) async{
   await service.postUsuario(usuario);
  }

  Future<bool> hayUsuario(String nombreUsuario) async{
    final usuarios = await service.getUsuarios();
    for (Usuario usuario in usuarios){
      if(usuario.nombreUsersAlan == nombreUsuario){
        return true;
      }
    }
    return false;
  }

  Future<Usuario?> traerUsuario(String nombreUsuario) async{
    final usuarios = await service.getUsuarios();
    for (Usuario usuario in usuarios){
      if(usuario.nombreUsersAlan == nombreUsuario){
        return usuario;
      }
    }
    return null;
  }

  Future<Usuario?> traerUsuarioPorId(int? id) async{
    final usuario = await service.getUsuarioPorId(id);
    
    return usuario;
  }
}