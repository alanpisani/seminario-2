import 'package:flutter/material.dart';
import '../../../models/usuario_model.dart';
import '../../../controllers/usuario_controller.dart';

class Validador {
  final _nombreController = TextEditingController();
  final _passController = TextEditingController();
  final _passDosController = TextEditingController();
  final _usuarioController = UsuarioController();
  Usuario? _usuarioValidado;

  //Getters
  TextEditingController get getNombreController => _nombreController;
  TextEditingController get getPassController => _passController;
  TextEditingController get getPassDosController => _passDosController;
  ///devuelve un usuario validado listo para ser logueado
  Usuario? get getUsuarioValidadoLogin => _usuarioValidado;

  //Metodos login

  bool _hayCamposVaciosLogin(){
    return _nombreController.text.isEmpty || _passController.text.isEmpty;
  }

  bool _hayUsuario(Usuario? usuario){
    return usuario != null;
  }

  bool _hayCoincidenciaPasswordLogin(Usuario? usuario){
    return _passController.text == usuario?.passUsersAlan;
  }

  ///Valida todas las credenciales del login. Devuelve un String en caso de que haya algo raro en los input. Si está todo piola, manda null
  Future<String?> validarCredencialesLogin() async{
    if(_hayCamposVaciosLogin()){
      return 'Se deben completar todos los datos';
    }
    else{
      final Usuario? usuarioEnDB = await _usuarioController.traerUsuario(_nombreController.text);
      if(!_hayUsuario(usuarioEnDB)){
        return "El usuario no existe";
      }
      else if(!_hayCoincidenciaPasswordLogin(usuarioEnDB)){
        return "La contraseña es incorrecta";
      }
      _usuarioValidado = usuarioEnDB;
      return null;
    }
  }

  //Metodos registro

  bool _hayCamposVaciosRegistro(){
    return _passDosController.text.isEmpty || _passController.text.isEmpty || _nombreController.text.isEmpty;
  }

  bool _hayCoincidenciaPasswords(){
    return _passController.text == _passDosController.text;
  }

  bool _hayEspacios(){
    return _nombreController.text.contains(' ') || _passController.text.contains(' ');
  }

  Future<bool> _usuarioExiste()async{
    return await _usuarioController.hayUsuario(_nombreController.text);
  } 
  
  ///Valida todas las credenciales del registro. Devuelve un String en caso de que haya algo raro en los input. Si está todo piola, manda null
  Future<String?> validarCredencialesRegistro()async{
    if(_hayCamposVaciosRegistro()) {
      return 'Todos los campos son obligatorios';
    }
    else if(_hayEspacios()){
      return 'El nombre de usuario y la contraseña no pueden contener espacios';
    }
    else if(!_hayCoincidenciaPasswords()) {
      return 'Las contraseñas no coinciden';
    }
    else if(await _usuarioExiste()){ 
      return 'Ese usuario ya existe';
    }
    return null;
  }

  ///Devuelve un Usuario totalmente validado para que el controller lo meta en la base de datos
  Usuario getUsuarioValidadoRegistro(){
    return Usuario(
      nombreUsersAlan: _nombreController.text, 
      passUsersAlan: _passController.text,
    );
  }


}