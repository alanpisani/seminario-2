class Puntaje{
  int? idUsersJuegos;
  int idJuego, idUser, puntajeUserJuego;

  Puntaje({
    this.idUsersJuegos,
    required this.idJuego,
    required this.idUser,
    required this.puntajeUserJuego
  });

  factory Puntaje.fromMap(Map <String, dynamic> mapa){
    return Puntaje(
      idUsersJuegos: mapa["id_users_juegos"] ?? 0,
      idJuego: mapa["id_juego"] ?? 0, 
      idUser: mapa["id_user"] ?? 0,
      puntajeUserJuego: mapa["puntaje_user_juego"] ?? 0
    );
  }

  Map<String, dynamic> toMap(){
    return{
      "id_juego": idJuego,
      "id_user": idUser,
      "puntaje_user_juego": puntajeUserJuego
    };
  }


}