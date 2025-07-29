class Logro{
  int? idLogroAlan;
  String nombreLogroAlan, descripcionLogroAlan, urlLogroAlan;
  bool desbloqueado;

  Logro({
    this.idLogroAlan,
    required this.nombreLogroAlan,
    required this.descripcionLogroAlan,
    required this.urlLogroAlan,
    this.desbloqueado = false
  });

  factory Logro.fromMap(Map<String, dynamic> mapa){
    return Logro(
      idLogroAlan: mapa['id_logro_alan'] ?? 0,
      nombreLogroAlan: mapa['nombre_logro_alan'] ?? '',
      descripcionLogroAlan: mapa['descripcion_logro_alan'] ?? '',
      urlLogroAlan: mapa['url_logro_alan'] ?? '',
      // desbloqueado: mapa['desbloqueado_alan'] ?? false
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'nombre_logro_alan': nombreLogroAlan,
      'descripcion_logro_alan': descripcionLogroAlan,
      'url_logro_alan': urlLogroAlan,
      // 'desbloqueado_alan': desbloqueado
    };
  }
}