// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../utils/logic/usuarios/sesionador.dart';
import '../models/asignacion_model.dart';
import '../services/asignacion_service.dart';
import '../utils/general/snackbar.dart';

class AsignacionController {
  final service = AsignacionService();

  Future<List<Asignacion>> traerAsignaciones() async{
    final List<Asignacion> asignaciones = await service.getAsignaciones();
    return asignaciones;
  }

  Future<List<Asignacion>> traerAsignacionPorIdDelUsuario(int idUser) async{
    List<Asignacion> asignaciones = await service.getAsignacionPorUserId(idUser);
    return asignaciones;
  }

  Future<void> procesoAsignarLogro(int idUser, int idLogro, BuildContext contexto) async{
    List<Asignacion> asignacionesDelUsuario = await traerAsignacionPorIdDelUsuario(idUser);
    for(int i = 0;i<asignacionesDelUsuario.length;i++){
      if(asignacionesDelUsuario[i].idLogrosAlan == idLogro){
        return;
      }
    }
    await service.postAsignacion(idUser, idLogro); //POSTEA

    //Logica de mostrar el logro ganado. Guarda aca

    asignacionesDelUsuario = await traerAsignacionPorIdDelUsuario(idUser);
    for(Asignacion asignacion in asignacionesDelUsuario){
      if(asignacion.idLogro == idLogro){
        mostrarSnackbar(asignacion.nombreLogroAlan, contexto);
        return;
      }
    }
  }

  Future<void> asignarLogro({required BuildContext contexto, required int idLogroAAsignar}) async{
    final int? idUsuario = await Sesionador.retornarId();
    if (idUsuario == null || idUsuario == 0 ) { return; }
    await procesoAsignarLogro(idUsuario, idLogroAAsignar, contexto);
  }
}