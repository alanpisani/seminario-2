class Asignacion {
  int? idLogrosUserAlan, idLogro, idUser;
  int idUsersAlan, idLogrosAlan;
  String nombreUsersAlan, nombreLogroAlan;

  Asignacion({
    this.idLogrosUserAlan,
    this.idLogro,
    this.idUser,
    required this.idUsersAlan,
    required this.idLogrosAlan,
    required this.nombreUsersAlan,
    required this.nombreLogroAlan,
    
  });

  factory Asignacion.fromMap(Map<String, dynamic> mapa){
    return Asignacion(
      idLogrosUserAlan: mapa['id_logros_user_alan'] ?? 0,
      idLogro: mapa['id_logro'] ?? 0,
      idUser: mapa['id_user'] ?? 0,
      idUsersAlan: mapa['id_users_alan'] ?? 0, 
      idLogrosAlan: mapa['id_logros_alan'] ?? 0, 
      nombreUsersAlan: mapa['nombre_users_alan'] ?? '',
      nombreLogroAlan: mapa['nombre_logro_alan'] ?? ''
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "id_logros_user_alan": idLogrosUserAlan,
      "id_users_alan": idUsersAlan,
      "id_logros_alan": idLogrosAlan,
      "nombre_users_alan": nombreUsersAlan,
      "nombre_logro_alan": nombreLogroAlan,
      "id_user": idUser,
      "id_logro": idLogro
    };
  }
}