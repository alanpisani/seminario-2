class Juego{
  int? idJuegosAlan;
  String tituloJuego;

  Juego({
    this.idJuegosAlan,
    required this.tituloJuego
  });

  factory Juego.fromMap(Map<String, dynamic> mapa){
    return Juego(
      idJuegosAlan: mapa["id_juegos_alan"] ?? 0,
      tituloJuego: mapa["titulo_juego"] ?? ''
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "titulo_juego": tituloJuego
    };
  }
}