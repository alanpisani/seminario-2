class Usuario{
  int? idUsersAlan;
  String nombreUsersAlan, passUsersAlan;

  Usuario({
    this.idUsersAlan,
    required this.nombreUsersAlan,
    required this.passUsersAlan
  });

  factory Usuario.fromMap(Map<String, dynamic> mapa){
    return Usuario(
      idUsersAlan: mapa['id_users_alan'] ?? 0,
      nombreUsersAlan: mapa['nombre_users_alan'] ?? '',
      passUsersAlan: mapa['pass_users_alan'] ?? ''
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'nombre_users_alan': nombreUsersAlan,
      'pass_users_alan': passUsersAlan
    };
  }
}