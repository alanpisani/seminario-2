import '/utils/logic/usuarios/sesionador.dart';

import '../../../controllers/asignacion_controller.dart';
import '../../../controllers/logro_controller.dart';
import '../../../models/asignacion_model.dart';
import '../../../models/logro_model.dart';


class FiltradorLogros {
  final _logroController = LogroController();
  final _asignacionController = AsignacionController();

  final List<Logro> _logrosDesbloqueados = [];
  final List<Logro> _logrosSinDesbloquear = [];

  List<Logro> get getLogrosDesbloqueados => _logrosDesbloqueados;
  List<Logro> get getLogrosSinDesbloquear => _logrosSinDesbloquear;


  Future<List<Logro>> _setearLogrosAVisiblesYRetornarlos(int idUsuario)async{
    final List<Logro> logros = await _logroController.traerLogros();
    final List<Asignacion> logrosUsuario = await _asignacionController.traerAsignacionPorIdDelUsuario(idUsuario);

    for(int i=0; i<logrosUsuario.length;i++){
      for(int j=0;j<logros.length;j++){
        if(logrosUsuario[i].nombreLogroAlan == logros[j].nombreLogroAlan){
            logros[j].desbloqueado = true;
            break;
        }
      }
    }
    return logros;
  }

  Future<void> traerLosLogros(bool mounted)async{
    final int? idUsuario = await Sesionador.retornarId();
    if (idUsuario == null || !mounted) return;
    final List<Logro> logrosUsuario = await _setearLogrosAVisiblesYRetornarlos(idUsuario);

    for(Logro logro in logrosUsuario){
      if(logro.desbloqueado){
        _logrosDesbloqueados.add(logro);
      }
      else{
        _logrosSinDesbloquear.add(logro);
      }
    }
  }
}

